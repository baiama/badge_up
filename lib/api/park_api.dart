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
    required String markAuto,
    required String modelAuto,
    required String numberAuto,
    required Function onSuccess,
    required Function onFailure,
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
