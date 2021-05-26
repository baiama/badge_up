import 'package:budge_up/api/settings_api.dart';
import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/utils/preference_helper.dart';

class SettingsProvider extends AuthProvider {
  SettingsApi _api = SettingsApi();
  PreferenceHelper _helper = PreferenceHelper();
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

  void logout(Function onSuccess) {
    _helper.clear(onSuccess: onSuccess);
  }

  UserModel get user => _user != null ? _user! : UserModel();
}
