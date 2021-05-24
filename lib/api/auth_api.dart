import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:dio/dio.dart';

class AuthApi {
  void login() {}

  void register(
      {required String name,
      required String phone,
      required email,
      required String password,
      required Function onSuccess,
      required Function(String) onFailure}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'name': name,
      "email": email,
      'password': password,
    });
    print(formData.fields);
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('registration/', data: formData);
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
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
