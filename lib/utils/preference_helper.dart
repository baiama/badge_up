import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  Future<String> get token async {
    var prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('token');
    if (jwt != null && jwt.length > 0) {
      return jwt;
    } else {
      return '';
    }
  }

  Future<String> get refreshToken async {
    var prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString('refresh');
    if (value != null && value.length > 0) {
      return value;
    } else {
      return '';
    }
  }

  void setToken(
      {required String token,
      required String refresh,
      required Function onSuccess}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refresh', refresh);
    onSuccess();
  }

  void setAccessToken(
      {required String token, required Function onSuccess}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    onSuccess();
  }

  void clear({required Function onSuccess}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refresh');
    onSuccess();
  }
}
