import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomIcons {
  static const addNew = 'assets/images/add_new_icon.svg';
  static const addPhoto = 'assets/images/add_photo_icon.svg';
  static const backIcon = 'assets/images/back_icon.svg';
  static const calendar = 'assets/images/calendar_icon.svg';
  static const call = 'assets/images/call_icon.svg';
  static const car = 'assets/images/car_icon.svg';
  static const clock = 'assets/images/clock.svg';
  static const edit = 'assets/images/edit_icon.svg';
  static const logo = 'assets/images/logo.svg';
  static const logout = 'assets/images/logout_icon.svg';
  static const park = 'assets/images/park_icon.svg';
  static const parking = 'assets/images/parking_icon.svg';
  static const remove = 'assets/images/remove_icon.svg';
  static const scanner = 'assets/images/scanner_icon.svg';
  static const settings = 'assets/images/settings_icon.svg';
  static const taxi = 'assets/images/taxi_icon.svg';
}

class CustomIcon extends StatelessWidget {
  final String customIcon;
  final Color? color;
  final double? width;
  final double? height;

  const CustomIcon({
    Key? key,
    required this.customIcon,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      customIcon,
      color: color,
      width: width,
      height: height,
    );
  }
}
