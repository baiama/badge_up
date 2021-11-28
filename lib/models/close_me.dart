import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/models/close_model.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:intl/intl.dart';

class CloseMe {
  late int id;
  late String phone;
  late bool active;
  late String datetime;
  late String closeNumber;
  late CloseModel close;
  late AutoModel closeGarageItem;
  late UserModel user;
  late AutoModel garageItem;

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

  void setPhone(String value){
    phone = value;
  }

  CloseMe() {
    id = 0;
    phone = '';
    active = false;
    datetime = '';
    closeNumber = '';
    close = CloseModel();
    user = UserModel();
    garageItem = AutoModel();
    closeGarageItem = AutoModel();
  }

  CloseMe.fromJson(Map? data) {
    if (data != null) {
      id = data['id'] != null ? data['id'] : 0;
      phone = data['phone'] != null ? data['phone'] : '';
      active = data['active'] != null
          ? data['active'] == 1
          ? true
          : false
          : false;
      datetime = data['datetime'] != null ? data['datetime'] : '';
      closeNumber = data['close_number'] != null ? data['close_number'] : '';

      user =
      data['user'] != null ? UserModel.fromJson(data['user']) : UserModel();
      garageItem = data['garage_item'] != null
          ? AutoModel.fromJson(data['garage_item'])
          : AutoModel();
      closeGarageItem = data['close_garage_item'] != null
          ? AutoModel.fromJson(data['close_garage_item'])
          : AutoModel();
      close = data['close'] != null
          ? CloseModel.fromJson(data['close'])
          : CloseModel();
    }
  }
}
