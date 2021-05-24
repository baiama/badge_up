import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/utils/strings.dart';

class RegisterProvider extends AuthProvider {
  void register() {
    if (name == null || name!.length == 0) {
      setError = Strings.errorEmpty + 'Имя';
      notifyListeners();
      return;
    }

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
