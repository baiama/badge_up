import 'package:budge_up/base/base_api.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:dio/dio.dart';

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
}
