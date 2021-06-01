class AutoModel {
  late int id;
  late String number;
  late String model;
  late String brand;
  late int userId;

  String get type {
    return '$model $brand';
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
      number = data['number'] != null ? data['number'] : '';
      model = data['model'] != null ? data['model'] : '';
      brand = data['brand'] != null ? data['brand'] : '';
      userId = data['user_id'] != null ? data['user_id'] : '';
    }
  }
}
