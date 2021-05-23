import 'package:budge_up/base/auth_provider.dart';

class RegisterProvider extends AuthProvider {
  void register() {
    if (name == null || name!.length == 0) {
      setError = error + 'Имя';
      notifyListeners();
      return;
    }
  }
}
