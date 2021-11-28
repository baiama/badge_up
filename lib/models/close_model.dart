import 'package:budge_up/models/user_model.dart';
import 'package:intl/intl.dart';

class CloseModel {
  late int id;
  late String phone;
  late bool active;
  late String datetime;
  late int garageId;
  late UserModel user;
  late String number;

  CloseModel() {
    id = 0;
    phone = '';
    active = false;
    datetime = '';
    garageId = 0;
    user = UserModel();
    number = '';
  }

  String get time {
    DateTime? parsedDate = DateTime.tryParse(datetime);
    if (parsedDate != null) {
      return DateFormat.Hm().format(parsedDate);
    }
    return '';
  }

  String get date {
    DateTime? parsedDate = DateTime.tryParse(datetime);
    if (parsedDate != null) {
      return DateFormat('dd.MM.yyyy').format(parsedDate);
    }
    return '';
  }

  CloseModel.fromJson(Map? data) {
    if (data != null) {
      id = data['id'] != null ? data['id'] : 0;
      phone = data['phone'] != null ? data['phone'] : '';
      active = data['active'] != null
          ? data['active'] == 1
              ? true
              : false
          : false;
      datetime = data['datetime'] != null ? data['datetime'] : '';
      garageId = data['garage_id'] != null ? data['garage_id'] : 0;
      user = data['user'] != null ? UserModel.fromJson(data['user']) : UserModel();
      number = data['close_number'] != null ? data['close_number'] : '';
    }
  }
}
