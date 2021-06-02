import 'package:budge_up/api/park_api.dart';
import 'package:budge_up/base/base_provider.dart';
import 'package:budge_up/models/park_model.dart';

class ParkProvider extends BaseProvider {
  List<ParkModel>? _results;
  List<ParkModel> get results => _results != null ? _results! : [];
  ParkApi _parkApi = ParkApi();

  void getItems() {
    _results = [];
    setIsLoading = false;
    if (!isLoading) {
      setIsLoading = true;
      _parkApi.getItems(
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

  void archive(ParkModel parkModel) {
    if (isLoading) {
      setIsLoading = true;
      _parkApi.archive(
          onSuccess: () {
            results.remove(parkModel);
            setIsLoading = false;
          },
          onFailure: () {
            setIsLoading = false;
          },
          id: parkModel.id);
    }
  }
}
