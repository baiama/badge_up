import 'package:budge_up/presentation/button_styles.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:flutter/material.dart';

class AutoDeleteDialog extends StatelessWidget {
  final Function onDeleteTap;
  const AutoDeleteDialog({Key? key, required this.onDeleteTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
          'Подтвердите удаление авто из гаража.'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onDeleteTap();
            Navigator.pop(context);
          },
          child: Text(Strings.delete1),
          style: kAlertElevatedButtonStyle,
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(Strings.cancel),
          style: kAlertElevatedButtonStyle,
        ),
      ],
    );
  }
}

