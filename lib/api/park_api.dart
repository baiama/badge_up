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
}
