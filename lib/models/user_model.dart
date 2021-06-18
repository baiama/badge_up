const String defaultImage =
    'https://datadezign.co.uk/wp-content/uploads/2020/04/user-default-grey.png';

class UserModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String photo;
  late String description;
  late bool isSendPush;
  late bool isEmailConfirm;

  UserModel() {
    id = 0;
    name = '';
    email = '';
    phone = '';
    photo = '';
    description = '';
    isSendPush = false;
    isEmailConfirm = false;
  }

  UserModel.fromJson(Map? data) {
    if (data != null) {
      id = data['id'] != null ? data['id'] : 0;
      name = data['name'] != null ? data['name'] : '';
      email = data['email'] != null ? data['email'] : '';
      var phoneJson = data['phone'] != null ? data['phone'] : '';
      phone = '+' + phoneJson;
      photo = data['photo'] != null ? data['photo'] : defaultImage;
      description = data['description'] != null ? data['description'] : '';
      isSendPush = data['is_send_push'] != null ? data['is_send_push'] : false;
      isEmailConfirm =
          data['is_email_confirm'] != null ? data['is_email_confirm'] : false;
    }
  }
}
