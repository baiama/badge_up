import 'package:budge_up/api/garage_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/auto_model.dart';

class ParkingAutoProvider extends BaseProvider {
  GarageApi _api = GarageApi();
  List<AutoModel>? _items;
  List<AutoModel> get items => _items != null ? _items! : [];
  void getItems() {
    _items = [];
    setIsRequestSend = false;
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
}
