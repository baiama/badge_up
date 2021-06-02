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
  String day = '';
  int month = 8;
  String year = '';
  String time = '';
  void _setUp() {
    _items = [];
    isViewSetup = false;
    _phone = '';
    number = '';
    day = '';
    month = 8;
    year = '';
    time = '';
    setIsRequestSend = false;
  }

  void getItems() {
    _setUp();
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

  bool get buttonIsEnabled {
    return phone.length > 0 &&
        selectedAuto.id > 0 &&
        day.length > 0 &&
        year.length == 4 &&
        time.length == 5;
  }

  void create({
    required Function onSuccess,
    required Function(String) onFailure,
    int? closeId,
    int? closeGarageId,
  }) {
    String date =
        '$year-${month < 10 ? '0$month' : month.toString()}-${day.length < 2 ? '0$day' : day.toString()} $time:00';
    print(date);
    // '2021-06-16 21:30:00'
    if (!isCreating) {
      setIsCreating = true;
      _parkApi.create(
        garageId: selectedAuto.id,
        datetime: date,
        phone: phone,
        closeId: closeId,
        closeGarageId: closeGarageId,
        closeNumber: number.length > 0 ? number : null,
        onSuccess: () {
          _setUp();
          onSuccess();
          setIsCreating = false;
        },
        onFailure: (value) {
          onFailure(value);
          setIsCreating = false;
        },
      );
    }
  }
}
