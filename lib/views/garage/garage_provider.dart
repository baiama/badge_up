import 'package:budge_up/base/base_provider.dart';

class GarageProvider extends BaseProvider {
  String _error = '';
  String? modelAuto;
  String? numberAuto;

  String get error => _error;

  set setError(String value) {
    _error = value;
    notifyListeners();
  }

  void getItems() {}
}
