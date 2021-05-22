import 'package:flutter/material.dart';

import 'custom_icons.dart';

class CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: kBackIcon);
  }
}
