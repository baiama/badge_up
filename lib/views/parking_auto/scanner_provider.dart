import 'dart:io';

import 'package:budge_up/api/scanner_api.dart';
import 'package:budge_up/base/base_provider.dart';

class ScannerProvider extends BaseProvider {
  ScannerApi _api = ScannerApi();

  void check(File? image) {
    if (image != null) {
      _api.scan(image: image);
    }
  }
}
