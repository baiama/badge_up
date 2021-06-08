class CloseModel {
  late int id;
  late String phone;
  late bool active;
  late String datetime;
  late int garageId;
  late int userId;

  CloseModel() {
    id = 0;
    phone = '';
    active = false;
    datetime = '';
    garageId = 0;
    userId = 0;
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
      userId = data['user_id'] != null ? data['user_id'] : 0;
    }
  }
}
