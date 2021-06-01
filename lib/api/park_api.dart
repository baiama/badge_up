import 'package:budge_up/base/base_api.dart';
import 'package:dio/dio.dart';

class ParkApi {
  void findAuto({
    required String number,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response =
          await dio.get('/parking/find/', queryParameters: {'number': number});
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
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
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    FormData formData = FormData.fromMap({
      "garage_id": garageId,
      'datetime': datetime,
      'phone': phone,
      'close_id': closeId,
      'close_garage_id': closeId,
      'close_number': closeId,
    });
    print(formData.fields);
    try {
      Response response = await dio.post(
        '/parking/',
        data: formData,
      );
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
      print(e.response!.realUri);
      onFailure();
    }
  }
}
