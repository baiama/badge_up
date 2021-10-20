import 'dart:io';
import 'dart:math';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Utils {
  static Future<File?> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File _image = File(pickedFile.path);
      return _image;
      File? cropped = await ImageCropper.cropImage(
          compressQuality: 30,
          sourcePath: _image.path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
          androidUiSettings: AndroidUiSettings(toolbarTitle: 'Редактор'),
          iosUiSettings: IOSUiSettings(title: 'Редактор'));
      return cropped;
    } else {
      print('No image selected.');
      return null;
    }
  }

  static Future<double> getFileSize(File file) async {
    int bytes = await file.length();
    if (bytes <= 0) return 0;
    return (bytes / pow(1024, 3));
  }

  static String formatAutoNumber(String number) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '# ### ## ### ### ### ### ##',
        filter: {"#": RegExp("[а-яА-Я0-9a-zA-Z]")});

    return maskFormatter.maskText(number);
  }

  static String formatPhoneNumber(String number) {
    if (!number.startsWith('+')) {
      number = '+' + number;
    }
    var maskFormatter = new MaskTextInputFormatter(
        mask: '##(###)###-##-##', filter: {"#": RegExp("[а-яА-Я0-9a-zA-Z+]")});

    return maskFormatter.maskText(number);
  }
}
