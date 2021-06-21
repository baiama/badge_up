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
  String? code;
  String? aboutMe;

  void setUpSettings() {
    image = null;
    code = null;
    aboutMe = null;
  }

  void getProfile(Function onSuccess) {
    if (!isRequestSend) {
      setIsRequestSend = true;
      _api.getProfile(onSuccess: (value) {
        _user = value;
        setIsRequestSend = false;
        onSuccess();
      }, onFailure: () {
        setIsRequestSend = false;
        onSuccess();
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

  void updateProfile({required Function onSuccess}) {
    if (image != null) {
      _safeImage();
    }
    if (!isLoading) {
      setIsLoading = true;
      _api.updateProfile(
        onSuccess: () {
          setIsLoading = false;
        },
        onFailure: (value) {
          setError = value;
          setIsLoading = false;
        },
        isSendPush: user.isSendPush,
        phone: phone != null && phone!.length > 0
            ? '7' + phone!
            : user.unMaskedPhone2,
        password: '',
        name: name != null && name!.length > 0 ? name! : user.name,
        email: email != null && email!.length > 0 ? email! : user.email,
        aboutMe: aboutMe,
      );
    }
  }

  void _safeImage() {
    if (!isLoading) {
      setIsLoading = true;
      _api.uploadAvatar(
        image: image!,
        onSuccess: () {
          setIsLoading = false;
        },
        onFailure: (value) {
          setIsLoading = false;
        },
      );
    }
  }
}
