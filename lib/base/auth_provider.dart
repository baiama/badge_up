import 'package:budge_up/api/auth_api.dart';
import 'package:budge_up/base/base_provider.dart';

class AuthProvider extends BaseProvider {
  AuthApi api = AuthApi();
  String? name;
  String? phone;
  String? email;
  String? password;
  String? passwordRepeat;
  String _error = '';
  String _error2 = '';

  void setUp() {
    name = null;
    phone = null;
    email = null;
    password = null;
    passwordRepeat = null;
    _error = '';
    _error2 = '';
  }

  String get error => _error;

  set setError(String value) {
    _error = value;
    notifyListeners();
  }

  String get error2 => _error2;

  set setError2(String value) {
    _error2 = value;
    notifyListeners();
  }
}
