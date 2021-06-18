import 'package:budge_up/api/garage_api.dart';
import 'package:budge_up/api/park_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/utils/strings.dart';

class ParkingAutoProvider extends BaseProvider {
  GarageApi _api = GarageApi();
  ParkApi _parkApi = ParkApi();
  List<AutoModel>? _items;
  List<AutoModel> get items => _items != null ? _items! : [];
  AutoModel? _selectedAuto;
  List<ParkModel>? _results;
  List<ParkModel> get results => _results != null ? _results! : [];
  ParkModel? _closePark;

  String _phone = '';
  String number = '';
  int day = 0;
  int month = 8;
  int year = 0;
  int hour = 0;
  int min = 0;
  String time = '';

  bool isOk = false;

  void _setUp() {
    isOk = false;
    DateTime now = DateTime.now();
    DateTime date =
        DateTime.utc(now.year, now.month, now.day, now.hour + 1, now.minute);
    number = '';
    day = date.day;
    month = date.month;
    year = date.year;
    min = date.minute;
    hour = date.hour;
    _closePark = null;
    _setTime();
    setIsRequestSend = false;
  }

  void _setTime() {
    time =
        '${hour < 10 ? '0$hour' : hour.toString()}:${min < 10 ? '0$min' : min.toString()}';
    notifyListeners();
  }

  void removeSelectedAuto() {
    _selectedAuto = AutoModel();
    notifyListeners();
  }

  void setDate(DateTime dateTime) {
    day = dateTime.day;
    year = dateTime.year;
    month = dateTime.month;
    notifyListeners();
  }

  void setTime(DateTime dateTime) {
    hour = dateTime.hour;
    min = dateTime.minute;
    _setTime();
  }

  void getItems() {
    _items = [];
    _selectedAuto = null;
    isViewSetup = false;
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
    _results = [];
    _closePark = null;
    setIsLoading = false;
    query = query.replaceAll(' ', '');
    print(query);
    if (!isLoading) {
      setIsLoading = true;
      _parkApi.findAuto(
        number: query,
        onSuccess: (value) {
          _results = value;
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

  ParkModel get closePark => _closePark != null ? _closePark! : ParkModel();

  set setClosePark(ParkModel value) {
    _closePark = value;
    notifyListeners();
  }

  set setClosePark2(ParkModel? value) {
    _closePark = value;
    notifyListeners();
  }

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
        day > 0 &&
        year > 4 &&
        time.length == 5;
  }

  void create({
    required Function onSuccess,
    required Function(String) onFailure,
    int? closeId,
    int? closeGarageId,
  }) {
    int currentMonth = month + 1;
    String date =
        '$year-${currentMonth < 10 ? '0$currentMonth' : currentMonth.toString()}-${day < 10 ? '0$day' : day.toString()} $time:00';
    print(date);
    // '2021-06-16 21:30:00'
    String closeNumber = '';
    if (_closePark != null) {
      closeNumber = _closePark!.garageItem.number;
    } else if (isOk) {
      closeNumber = number;
    }
    if (!isCreating) {
      setIsCreating = true;
      _parkApi.create(
        garageId: selectedAuto.id,
        datetime: date,
        phone: phone,
        closeId: _closePark != null ? _closePark!.id : null,
        closeGarageId: _closePark != null ? _closePark!.garageItem.id : null,
        closeNumber: closeNumber.length > 0 ? closeNumber : null,
        onSuccess: () {
          _setUp();
          _phone = '';
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
