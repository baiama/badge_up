import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:dio/dio.dart';

class GarageApi {
  void create({
    required String markAuto,
    required String modelAuto,
    required String numberAuto,
    required Function onSuccess,
    required Function(String) onFailure,
    required int id,
  }) async {
    Dio dio = await BaseApi().dio;
    FormData formData = FormData.fromMap({
      "number": numberAuto,
      'model': modelAuto,
      'brand': markAuto,
    });
    print(formData.fields);
    print(id);
    try {
      Response response = id == 0
          ? await dio.post(
              'profile/garage/',
              data: formData,
            )
          : await dio.put(
              'profile/garage/$id/',
              data: formData,
            );
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
      print(e.response!.realUri);
      if (e.response != null && e.response!.statusCode != null) {
        if (e.response!.statusCode! > 399 && e.response!.statusCode! < 500) {
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

  void getItems({
    required Function(List<AutoModel>) onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.get(
        'profile/garage/',
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Iterable itemsJson = response.data['items'];
        List<AutoModel> items =
            itemsJson.map((i) => AutoModel.fromJson(i)).toList();
        onSuccess(items);
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void delete({
    required Function onSuccess,
    required Function onFailure,
    required int id,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.delete(
        'profile/garage/$id/',
      );
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
}
