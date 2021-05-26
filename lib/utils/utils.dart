import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<File?> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      File _image = File(pickedFile.path);
      return _image;
    } else {
      print('No image selected.');
      return null;
    }
  }
}
