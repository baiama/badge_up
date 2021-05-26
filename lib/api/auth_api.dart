import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/utils/preference_helper.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:dio/dio.dart';

class AuthApi {
  void login(
      {required email,
      required String password,
      required Function onSuccess,
      required Function(String) onFailure}) async {
    FormData formData = FormData.fromMap({
      "login": email,
      'password': password,
    });
    print(formData.fields);
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('token/', data: formData);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        String token = response.data['access_token'];
        PreferenceHelper().setToken(token: token, onSuccess: onSuccess);
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      print(e);
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
      print(e.response);
      print(e.response!.realUri);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }

  void refreshToken(
      {required Function onSuccess, required Function onFailure}) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('token/refresh/');
      if (response.statusCode == 201 || response.statusCode == 200) {
        String token = response.data['access_token'];
        PreferenceHelper().setToken(token: token, onSuccess: onSuccess);
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void resetPassword(
      {required email,
      required Function onSuccess,
      required Function(String) onFailure}) async {
    FormData formData = FormData.fromMap({
      "email": email,
    });
    print(formData.fields);
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('restore/email/', data: formData);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        onSuccess();
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      print(e);
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
      print(e.response);
      print(e.response!.realUri);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }

  void register(
      {required String name,
      required String phone,
      required email,
      required String password,
      required String passwordConfirm,
      required Function onSuccess,
      required Function(String) onFailure}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'name': name,
      "email": email,
      'password': password,
      'password_confirmation': passwordConfirm,
    });
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('registration/', data: formData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        String token = response.data['access_token'];
        PreferenceHelper().setToken(token: token, onSuccess: onSuccess);
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      print(e);
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
      print(e.response);
      print(e.response!.realUri);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
