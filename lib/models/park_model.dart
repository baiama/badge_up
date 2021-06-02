import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/models/user_model.dart';

class ParkModel {
  late int id;
  late String phone;
  late bool active;
  late String datetime;

  late int closeNumber;
  late int close;
  late int closeGarageItem;

  late UserModel user;
  late AutoModel garageItem;

  ParkModel() {
    id = 0;
    phone = '';
    active = false;
    datetime = '';

    user = UserModel();
    garageItem = AutoModel();
  }

  ParkModel.fromJson(Map? data) {
    if (data != null) {
      id = data['id'] != null ? data['id'] : 0;
      phone = data['phone'] != null ? data['phone'] : '';
      active = data['active'] != null ? data['active'] : false;
      datetime = data['datetime'] != null ? data['datetime'] : '';

      user =
          data['user'] != null ? UserModel.fromJson(data['user']) : UserModel();
      garageItem = data['garage_item'] != null
          ? AutoModel.fromJson(data['garage_item'])
          : AutoModel();
    }
  }
}