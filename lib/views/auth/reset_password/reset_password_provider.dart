import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class ResetPasswordProvider extends AuthProvider {
  void resetPassword({required Function onSuccess}) {
    if (email == null || email!.length == 0) {
      setError = Strings.errorEmpty + 'Email';
      notifyListeners();
      return;
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!)) {
      setError = Strings.errorEmpty2 + 'Email';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;

      api.resetPassword(
          onSuccess: () {
            setIsRequestSend = false;
            onSuccess();
          },
          email: email!,
          onFailure: (value) {
            setError = value;
            setIsRequestSend = false;
          });
    }
  }
}
