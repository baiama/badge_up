import 'package:budge_up/presentation/color_scheme.dart';
import 'package:flutter/material.dart';

class AvatarItem extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  const AvatarItem({
    Key? key,
    required this.image,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: kColorF6F6F6,
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image: NetworkImage(image),
        ),
        boxShadow: [
          BoxShadow(
            color: kColor26656565,
            spreadRadius: 3,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
      ),
    );
  }
}
