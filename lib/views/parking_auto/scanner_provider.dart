import 'dart:io';

import 'package:budge_up/api/scanner_api.dart';
import 'package:budge_up/base/base_provider.dart';

class ScannerProvider extends BaseProvider {
  ScannerApi _api = ScannerApi();
  String? error;
  String? plateNum;

  void check(File? image) async {
    error = null;
    await Future.delayed(Duration(seconds: 1));
    if (!isRequestSend) {
      setIsRequestSend = true;
      if (image != null) {
        _api.scan(
          image: image,
          onSuccess: (value) {
            plateNum = value;
            setIsRequestSend = false;
          },
          onFailure: (error) {
            this.error = error;
            setIsRequestSend = false;
          },
        );
      }
    }
  }
}
