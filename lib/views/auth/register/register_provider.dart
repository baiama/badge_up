import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class RegisterProvider extends AuthProvider {
  void register({required Function onSuccess}) {
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

    if (password == null || password!.length == 0) {
      setError = Strings.errorEmpty + 'Пароль';
      notifyListeners();
      return;
    }

    if (password!.length < 6) {
      setError = 'Пароль должен быть, не менее 5 символов';
      notifyListeners();
      return;
    }

    if (passwordRepeat == null || passwordRepeat!.length == 0) {
      setError = Strings.errorEmpty + 'Повторите пароль';
      notifyListeners();
      return;
    }

    if (password! != passwordRepeat!) {
      setError = Strings.errorEmpty + 'Пароли не совподают';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;
      api.register(
        onSuccess: () {
          setIsRequestSend = false;
          onSuccess();
        },
        email: email!,
        name: name!,
        password: password!,
        phone: phone!,
        passwordConfirm: passwordRepeat!,
        onFailure: (value) {
          setError = value;
          setIsRequestSend = false;
        },
      );
    }
  }
}
