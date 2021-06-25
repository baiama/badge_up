import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

class CodeView extends StatefulWidget {
  const CodeView({
    Key? key,
  }) : super(key: key);

  @override
  _CodeViewState createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 24,
        child: Consumer<SettingsProvider>(
          builder: (BuildContext context, provider, Widget? child) {
            return Column(
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
                    provider.code = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Код подтверждения',
                  ),
                ),
                SizedBox(height: 26),
                ElevatedButton(
                    onPressed: () {
                      provider.confirm(() async {
                        FocusScope.of(context).unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'Ваш email подвержлен.',
                              style: kInterReg16ColorBlack,
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      });
                    },
                    child:
                        provider.isLoading ? CircularLoader() : Text('Готово')),
                if (provider.error2.length > 0) SizedBox(height: 20),
                if (provider.error2.length > 0)
                  Text(
                    provider.error2,
                    style: kInterReg16ColorCC6666,
                    textAlign: TextAlign.center,
                  ),
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
            );
          },
        ),
      ),
    );
  }
}
