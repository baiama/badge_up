import 'package:budge_up/api/settings_api.dart';
import 'package:budge_up/base/base_provider.dart';

class SettingsProvider extends BaseProvider {
  SettingsApi _api = SettingsApi();

  void getProfile() {
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getProfile(onSuccess: () {
        setIsRequestSend = false;
      }, onFailure: () {
        setIsRequestSend = false;
      });
    }
  }
}
