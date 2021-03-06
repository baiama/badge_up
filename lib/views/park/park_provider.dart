import 'package:budge_up/api/park_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/park_model.dart';

class ParkProvider extends BaseProvider {
  List<ParkModel>? _results;
  List<ParkModel> get results => _results != null ? _results! : [];
  ParkApi _parkApi = ParkApi();
  int id = 0;
  void getItems() {
    isViewSetup = false;
    _results = [];
    id = 0;
    setIsRequestSend = false;
    if (!isRequestSend) {
      setIsRequestSend = true;
      _parkApi.getItems(
        onSuccess: (value) {
          _results = value;
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

  void archive(ParkModel parkModel) {
    id = parkModel.id;
    if (!isLoading) {
      setIsLoading = true;
      _parkApi.archive(
          onSuccess: () {
            results.removeWhere((element) => element.id == parkModel.id);
            id = 0;
            setIsLoading = false;
          },
          onFailure: () {
            id = 0;
            setIsLoading = false;
          },
          id: parkModel.id);
    }
  }

  void updatePhone(String value, ParkModel parkModel){
    id = parkModel.id;
    if (!isLoading) {
      setIsLoading = true;
      String phone = value.replaceAll('+', '');
      _parkApi.updatePhone(
          onSuccess: () {
            id = 0;
            setIsLoading = false;
            parkModel.setPhone(phone);
          },
          onFailure: () {
            id = 0;
            setIsLoading = false;
          },
          id: parkModel.id, phone: phone);
    }
  }
}
