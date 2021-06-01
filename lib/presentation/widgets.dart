import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: CustomIcon(customIcon: CustomIcons.backIcon));
  }
}

class CircularLoader extends StatelessWidget {
  const CircularLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(),
    );
  }
}

class EmptyData extends StatelessWidget {
  final String title;
  const EmptyData({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomIcon(customIcon: CustomIcons.car),
          SizedBox(height: 30),
          Text(
            title,
            style: kInterReg16ColorBlack,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
