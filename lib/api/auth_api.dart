import 'package:budge_up/base/base_api.dart';
import 'package:dio/dio.dart';

class AuthApi {
  void login() {}

  void register(
      String name, String phone, String email, String password) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'name': name,
      "email": email,
      'password': password,
    });
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('registration/', data: formData);
      print(response.data);
      if (response.statusCode == 201) {
      } else {
        // Map<UserErrors, String> errors = Map<UserErrors, String>();
        // errors[UserErrors.password] = Strings.error;
        // onFailure(errors);
      }
    } on DioError catch (e) {
      print(e);
      print(e.response);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
