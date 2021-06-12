import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AutoModel {
  late int id;
  late String number;
  late String model;
  late String brand;
  late int userId;

  String get type {
    return '$brand $model';
  }

  AutoModel() {
    id = 0;
    number = '';
    model = '';
    brand = '';
    userId = 0;
  }

  AutoModel.fromJson(Map? data) {
    if (data != null) {
      id = data['id'] != null ? data['id'] : 0;
      model = data['model'] != null ? data['model'] : '';
      brand = data['brand'] != null ? data['brand'] : '';
      userId = data['user_id'] != null ? data['user_id'] : '';
      String numberJson = data['number'] != null ? data['number'] : '';
      number = maskFormatter.maskText(numberJson);
    }
  }

  var maskFormatter = new MaskTextInputFormatter(
  mask: '# ### ## ### ### ### ### ##', filter: {"#": RegExp("[а-яА-Я0-9a-zA-Z]")});
}


