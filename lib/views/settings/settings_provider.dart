import 'package:budge_up/api/settings_api.dart';
import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/models/user_model.dart';

class SettingsProvider extends AuthProvider {
  SettingsApi _api = SettingsApi();
  UserModel? _user;

  void getProfile() {
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getProfile(onSuccess: (value) {
        _user = value;
        setIsRequestSend = false;
      }, onFailure: () {
        setIsRequestSend = false;
      });
    }
  }

  UserModel get user => _user != null ? _user! : UserModel();
}
