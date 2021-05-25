import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomIcons {
  static const logo = 'assets/images/logo.svg';
  static const backIcon = 'assets/images/back_icon.svg';
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
