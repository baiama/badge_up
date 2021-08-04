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

  void setToken({required String token, required Function onSuccess}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    onSuccess();
  }

  void clear({required Function onSuccess}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('fcm_token');
    onSuccess();
  }

  void setFcmToken({required String token}) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
  }

  Future<String> get fcmToken async {
    var prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('fcm_token');
    if (jwt != null && jwt.length > 0) {
      return jwt;
    } else {
      return '';
    }
  }
}
