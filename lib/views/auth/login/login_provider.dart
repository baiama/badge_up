import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class LoginProvider extends AuthProvider {
  void login({required Function onSuccess}) {
    if (email == null || email!.length == 0) {
      setError = Strings.errorEmpty + 'Телефон или Email';
      notifyListeners();
      return;
    }

    if (password == null || password!.length == 0) {
      setError = Strings.errorEmpty + 'Пароль';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;
      api.login(
          onSuccess: () {
            setIsRequestSend = false;
            onSuccess();
          },
          email: email!,
          password: password!,
          onFailure: (value) {
            setError = value;
            setIsRequestSend = false;
          });
    }
  }
}
