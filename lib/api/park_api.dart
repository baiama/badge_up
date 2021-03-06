import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:dio/dio.dart';

class ParkApi {
  void findAuto({
    required String number,
    required Function(List<ParkModel>) onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    print(number);
    try {
      Response response =
          await dio.get('/parking/find/', queryParameters: {'number': number});
      if (response.statusCode == 201 || response.statusCode == 200) {
        Iterable itemsJson = response.data['items'];
        List<ParkModel> items =
            itemsJson.map((i) => ParkModel.fromJson(i)).toList();
        onSuccess(items);
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void getItems({
    required Function(List<ParkModel>) onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.get('parking/');
      // print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        Iterable itemsJson = response.data['items'];
        List<ParkModel> items =
            itemsJson.map((i) => ParkModel.fromJson(i)).toList();
        onSuccess(items);
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void archive({
    required Function onSuccess,
    required Function onFailure,
    required int id,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('parking/$id/archive/');
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void updatePhone({
    required Function onSuccess,
    required Function onFailure,
    required int id,
    required String phone,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.put(
        'parking/$id/',
        data: {'phone': phone},
        options: Options(
            followRedirects: false,
            headers: {'content-type': 'application/json'},
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void create({
    required int garageId,
    required String datetime,
    required String phone,
    required int? closeId,
    required int? closeGarageId,
    required String? closeNumber,
    required Function onSuccess,
    required Function(String) onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    FormData formData = FormData.fromMap({
      "garage_id": garageId,
      'datetime': datetime,
      'phone': phone,
      'close_id': closeId,
      'close_garage_id': closeGarageId,
      'close_number': closeNumber,
    });
    try {
      Response response = await dio.post(
        '/parking/',
        data: formData,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 400 ||
            e.response!.statusCode == 401 ||
            e.response!.statusCode == 404) {
          String err = e.response!.data['error'];
          onFailure(err);
        } else {
          onFailure(Strings.errorEmpty3);
        }
      } else {
        onFailure(Strings.errorEmpty3);
      }
    }
  }
}
