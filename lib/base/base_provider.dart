import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  bool _isRequestSend = false;
  bool _isLoading = false;
  bool isViewSetup = false;

  set setIsRequestSend(bool value) {
    _isRequestSend = value;
    notifyListeners();
  }

  bool get isRequestSend => _isRequestSend;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
