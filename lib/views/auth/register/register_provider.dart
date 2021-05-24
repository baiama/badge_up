import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class RegisterProvider extends AuthProvider {
  void register() {
    if (name == null || name!.length == 0) {
      setError = Strings.errorEmpty + 'Имя';
      notifyListeners();
      return;
    }
    if (phone == null || phone!.length == 0) {
      setError = Strings.errorEmpty + 'Телефон';
      notifyListeners();
      return;
    }

    if (!phone!.startsWith('+')) {
      phone = '+' + phone!;
    }

    if (phone!.length != 12) {
      setError = Strings.errorEmpty2 + 'Телефон';
      notifyListeners();
      return;
    }

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

    api.register(
        onSuccess: () {},
        email: email!,
        name: name!,
        password: password!,
        phone: phone!,
        onFailure: (value) {
          setError = value;
        });
  }
}
