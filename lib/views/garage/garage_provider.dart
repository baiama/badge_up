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
  int id = 0;
  String get error => _error;
  void setUp() {
    _error = '';
    modelAuto = null;
    markAuto = null;
    numberAuto = null;
    isViewSetup = false;
  }

  List<AutoModel> get items => _items != null ? _items! : [];

  set setError(String value) {
    _error = value;
    notifyListeners();
  }

  void delete(int value) {
    id = value;
    if (!isLoading) {
      setIsLoading = true;
      _api.delete(
        onSuccess: () {
          items.removeWhere((element) => element.id == value);
          id = 0;
          setIsLoading = false;
        },
        onFailure: () {
          id = 0;
          setIsLoading = false;
        },
        id: value,
      );
    }
  }

  void getItems() {
    _items = [];
    isViewSetup = false;
    setIsRequestSend = false;
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getItems(
        onSuccess: (value) {
          _items = value;
          isViewSetup = true;
          setIsRequestSend = false;
        },
        onFailure: () {
          isViewSetup = true;
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
