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

  Future<void> create({required int id, required Function onSuccess}) async {
    if (markAuto == null || markAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Марка авто';
      notifyListeners();
      return;
    }

    if (markAuto!.length > 50) {
      setError = 'Марка максимум 50 символов';
      notifyListeners();
      return;
    }

    if (modelAuto == null || modelAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Модель авто';
      notifyListeners();
      return;
    }

    if (modelAuto!.length > 50) {
      setError = 'Модель максимум 50 символов';
      notifyListeners();
      return;
    }

    if (numberAuto == null || numberAuto!.length == 0) {
      setError = Strings.errorEmpty + 'Номер авто';
      notifyListeners();
      return;
    }

    if (numberAuto!.trim().length > 15) {
      setError = 'Номер авто максимум 15 символов';
      notifyListeners();
      return;
    }

    setError = '';
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.create(
        id: id,
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
