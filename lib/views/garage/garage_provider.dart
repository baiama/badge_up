import 'package:budge_up/api/garage_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/utils/strings.dart';

class GarageProvider extends BaseProvider {
  String _error = '';
  String? modelAuto;
  String? markAuto;
  String? numberAuto;
  GarageApi _api = GarageApi();
  List<AutoModel>? _items;

  String get error => _error;

  void setUp() {
    _error = '';
    modelAuto = null;
    markAuto = null;
    numberAuto = null;
  }

  List<AutoModel> get items => _items != null ? _items! : [];

  set setError(String value) {
    _error = value;
    notifyListeners();
  }

  void getItems() {
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getItems(
        onSuccess: (value) {
          _items = value;
          setIsRequestSend = false;
        },
        onFailure: () {
          setIsRequestSend = false;
        },
      );
    }
  }

  void create({required Function onSuccess}) {
    if (modelAuto == null || modelAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Марка авто';
      notifyListeners();
      return;
    }
    if (modelAuto == null || modelAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Модель авто';
      notifyListeners();
      return;
    }

    if (numberAuto == null || numberAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Номер авто';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.create(
        onSuccess: () {
          setIsRequestSend = false;
          onSuccess();
        },
        onFailure: () {
          setIsRequestSend = false;
        },
        numberAuto: numberAuto!,
        modelAuto: modelAuto!,
        markAuto: markAuto!,
      );
    }
  }
}
