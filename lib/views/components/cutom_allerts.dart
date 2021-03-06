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

class SingOutDialog extends StatelessWidget {
  final Function onTap;
  const SingOutDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
          'Вы уверены, что хотите выйти?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onTap();
            Navigator.pop(context);
          },
          child: Text(Strings.yes),
          style: kAlertElevatedButtonStyle,
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(Strings.no),
          style: kAlertElevatedButtonStyle,
        ),
      ],
    );
  }
}


class ParkArchiveDialog extends StatelessWidget {
  final Function onTap;
  const ParkArchiveDialog({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
          'Вы уверены, что решили уехать?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            onTap();
            Navigator.pop(context);
          },
          child: Text(Strings.yes),
          style: kAlertElevatedButtonStyle,
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(Strings.no),
          style: kAlertElevatedButtonStyle,
        ),
      ],
    );
  }
}

