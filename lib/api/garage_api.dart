import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/models/auto_model.dart';
import 'package:dio/dio.dart';

class GarageApi {
  void create({
    required String markAuto,
    required String modelAuto,
    required String numberAuto,
    required Function onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    FormData formData = FormData.fromMap({
      "number": numberAuto,
      'model': modelAuto,
      'brand': markAuto,
    });
    try {
      Response response = await dio.post(
        'profile/garage/',
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
      onFailure();
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
      print(response.data);
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
}
