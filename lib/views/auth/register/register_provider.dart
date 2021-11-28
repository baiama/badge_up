import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class RegisterProvider extends AuthProvider {
  String addText(String text, String addText) {
    if (text.length == 0) {
      text = text + addText;
    } else {
      text = text + ', ' + addText;
    }
    print(text);
    return text;
  }

  void register({required Function onSuccess}) {
    String text = "";
    if (name == null || name!.length == 0) {
      text = addText(text, 'Имя');
    }
    if (phone == null || phone!.length == 0) {
      text = addText(text, 'Телефон');
    }

    if (email == null || email!.length == 0) {
      text = addText(text, 'Email');
    }

    if (password == null || password!.length == 0) {
      text = addText(text, 'Пароль');
    }

    if (passwordRepeat == null || passwordRepeat!.length == 0) {
      text = addText(text, 'Повторите пароль');
    }

    if (text.length > 0) {
      setError = Strings.errorEmpty1 + text;
      notifyListeners();
      return;
    }

    phone = '7' + phone!;
    print(phone);
    if (phone!.length != 11) {
      setError = Strings.errorEmpty2 + 'Телефон';
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

    if (password!.length < 5) {
      setError = 'Пароль должен быть, не менее 5 символов';
      notifyListeners();
      return;
    }

    if (password! != passwordRepeat!) {
      setError = 'Пароли не совподают';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;
      api.register(
        onSuccess: () {
          setIsRequestSend = false;
          setError = '';
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
