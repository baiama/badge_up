import 'dart:io';

import 'package:budge_up/api/settings_api.dart';
import 'package:budge_up/base/auth_provider.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/utils/preference_helper.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends AuthProvider {
  SettingsApi _api = SettingsApi();
  PreferenceHelper _helper = PreferenceHelper();
  UserModel? _user;
  File? image;

  void getProfile(Function onSuccess) {
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getProfile(onSuccess: (value) {
        _user = value;
        setIsRequestSend = false;
      }, onFailure: () {
        setIsRequestSend = false;
      });
    }
  }

  void logout(Function onSuccess) {
    _helper.clear(onSuccess: onSuccess);
  }

  void updateView() {
    notifyListeners();
  }

  UserModel get user => _user != null ? _user! : UserModel();

  ImageProvider get currentImage {
    if (image != null) {
      return FileImage(image!);
    }
    return NetworkImage(user.photo);
  }
}
