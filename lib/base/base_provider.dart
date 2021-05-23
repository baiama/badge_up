import 'package:flutter/foundation.dart';

class BaseProvider with ChangeNotifier {
  bool _isRequestSend = false;

  set setIsRequestSend(bool value) {
    _isRequestSend = value;
    notifyListeners();
  }

  bool get isRequestSend => _isRequestSend;
}
