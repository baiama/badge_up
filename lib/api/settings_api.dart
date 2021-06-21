import 'dart:io';

import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class SettingsApi {
  void getProfile({
    required Function(UserModel) onSuccess,
    required Function onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.get(
        'profile/',
      );
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        onSuccess(user);
      } else {
        onFailure();
      }
    } on DioError catch (e) {
      print(e);
      onFailure();
    }
  }

  void uploadAvatar({
    required File image,
    required Function onSuccess,
    required Function(String) onFailure,
  }) async {
    Dio dio = await BaseApi().dio;
    FormData formData = FormData();
    MultipartFile multipartFile = MultipartFile.fromFileSync(image.path,
        filename: image.path, contentType: MediaType("image", "png"));
    formData = FormData.fromMap({
      'photo': multipartFile,
    });

    try {
      Response response = await dio.post('profile/photo', data: formData);
      print(response);
      print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        onSuccess();
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
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
      print(e.response);
      print(e.response!.realUri);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }

  void updateProfile(
      {required String? name,
      required String? phone,
      required String? email,
      required String? password,
      required String? aboutMe,
      required bool isSendPush,
      required Function(UserModel) onSuccess,
      required Function(String) onFailure}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'name': name,
      "email": email,
      "description": aboutMe,
      "is_send_push": isSendPush,
      // 'password': '123456',
      // 'password_confirmation': '123456',
    });
    print(formData.fields);
    Dio dio = await BaseApi().dio;
    try {
      Response response = await dio.post('profile/', data: formData);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        UserModel user = UserModel.fromJson(response.data);
        onSuccess(user);
      } else {
        onFailure(Strings.errorEmpty3);
      }
    } on DioError catch (e) {
      print(e);
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
      print(e.response);
      print(e.response!.realUri);
      print(e.response!.statusCode);
      print(e.response!.data);
    }
  }
}
