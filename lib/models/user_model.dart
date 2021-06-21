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

  String get desc {
    if (description.length == 0) {
      return 'Здесь написано обо мне';
    }
    return description;
  }

  String get unMaskedPhone {
    var value = phone;
    if (value.startsWith('+')) {
      value = value.substring(1, value.length - 1);
    }
    if (value.startsWith('7')) {
      value = value.substring(1, value.length - 1);
    }

    return value;
  }

  String get unMaskedPhone2 {
    var value = phone;
    value = value.replaceAll('+', '');
    return value;
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
      var pushJson = data['is_send_push'];
      if (pushJson != null) {
        if (pushJson is int) {
          if (pushJson == 1) {
            isSendPush = true;
          } else {
            isSendPush = false;
          }
        } else if (pushJson is bool) {
          isSendPush = pushJson;
        }
      } else {
        isSendPush = true;
      }
      isEmailConfirm =
          data['is_email_confirm'] != null ? data['is_email_confirm'] : false;
    }
  }
}
