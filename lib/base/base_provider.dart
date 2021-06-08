import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  bool _isRequestSend = false;
  bool _isLoading = false;
  bool _isCreating = false;
  bool isViewSetup = false;

  bool get isRequestSend => _isRequestSend;

  bool get isLoading => _isLoading;

  bool get isCreating => _isCreating;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setIsRequestSend(bool value) {
    _isRequestSend = value;
    notifyListeners();
  }

  set setIsCreating(bool value) {
    _isCreating = value;
    notifyListeners();
  }
}
