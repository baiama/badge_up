import 'package:budge_up/api/garage_api.dart';
import 'package:budge_up/api/park_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/auto_model.dart';

class ParkingAutoProvider extends BaseProvider {
  GarageApi _api = GarageApi();
  ParkApi _parkApi = ParkApi();
  List<AutoModel>? _items;
  List<AutoModel> get items => _items != null ? _items! : [];
  AutoModel? _selectedAuto;
  String _phone = '';
  String number = '';

  void getItems() {
    _items = [];
    isViewSetup = false;
    _phone = '';
    number = '';
    setIsRequestSend = false;
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getItems(
        onSuccess: (value) {
          _items = value;
          if (items.length > 0) {
            _selectedAuto = items[0];
          }
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

  void findAuto(String query) {
    setIsLoading = false;
    if (!isLoading) {
      setIsLoading = true;
      _parkApi.findAuto(
        number: query,
        onSuccess: () {
          setIsLoading = false;
        },
        onFailure: () {
          isViewSetup = true;
          setIsLoading = false;
        },
      );
    }
  }

  AutoModel get selectedAuto =>
      _selectedAuto != null ? _selectedAuto! : AutoModel();

  set setSelectedAuto(AutoModel value) {
    _selectedAuto = value;
    notifyListeners();
  }

  String get phone => _phone;

  set setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void updateView() {
    notifyListeners();
  }

  void create() {}
}
