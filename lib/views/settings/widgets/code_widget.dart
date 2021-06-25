import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

class CodeWidget extends StatelessWidget {
  final Function onCodeTap;
  final Function onResendTap;
  final bool confirmed;
  const CodeWidget({
    Key? key,
    required this.onCodeTap,
    required this.onResendTap,
    required this.confirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            onCodeTap();
          },
          child: Container(
            padding: EdgeInsets.only(left: 24, top: 14, bottom: 14, right: 24),
            decoration: BoxDecoration(
              color: kColorF6F6F6,
              border: Border.all(
                color: kColorE8E8E8,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: Text(
              'Код подтверждения',
              style: kInterReg16ColorCC6666,
            ),
          ),
        ),
        if (confirmed)
          GestureDetector(
            onTap: () {
              onResendTap();
            },
            child: Container(
              padding: EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              child: Text(
                'Выслать повторно',
                style: kInterReg14.copyWith(
                  color: kColor2980B9,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CodeView extends StatelessWidget {
  final Function(String) onChange;
  final Function onTap;
  const CodeView({
    Key? key,
    required this.onChange,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Подтвердить email',
              style: kInterSemiBold18,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 26),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) {
                onChange(value);
              },
              decoration: InputDecoration(
                hintText: 'Код подтверждения',
              ),
            ),
            SizedBox(height: 26),
            ElevatedButton(
                onPressed: () {
                  onTap();
                  Navigator.pop(context);
                },
                child: Text('Готово')),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 26),
                child: Text(
                  'Отменить',
                  style: kInterReg16ColorCC6666.copyWith(
                    color: kColor2980B9,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
