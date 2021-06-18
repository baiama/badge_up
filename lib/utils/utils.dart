import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

  static String formatAutoNumber(String number) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '# ### ## ### ### ### ### ##',
        filter: {"#": RegExp("[а-яА-Я0-9a-zA-Z]")});

    return maskFormatter.maskText(number);
  }
}
