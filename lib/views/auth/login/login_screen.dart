import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/auth/login/login_provider.dart';
import 'package:budge_up/views/auth/reset_password/reset_password.dart';
import 'package:budge_up/views/home/home_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CustomBackButton(),
          title: Text('Авторизация'),
        ),
        body: LoginBody(),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  var textInputMask = MaskTextInputFormatter(
      mask: '+7(###)###-##-##', filter: {"#": RegExp(r'[0-9]')});
  var hint = 'Телефон';
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta != null) {
          if (details.primaryDelta! > 15 || details.primaryDelta! < 15) {
            FocusScope.of(context).unfocus();
          }
        }
      },
      child: Consumer<LoginProvider>(
        builder: (BuildContext context, provider, Widget? child) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: kColorF6F6F6,
                    border: Border.all(
                      color: kColorE8E8E8,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return LoginExp(onSelected: (vale) {
                                  if (vale == 1) {
                                    setState(() {
                                      hint = 'Email';
                                      textController.value = textInputMask
                                          .updateMask(
                                              mask:
                                                  '######################################',
                                              filter: {
                                            "#": RegExp(
                                                r'^[a-zA-Z0-9_\-=@,\.;]+$')
                                          });
                                    });
                                  } else if (vale == 2) {
                                    setState(() {
                                      hint = 'Телефон';
                                      textController.value = textInputMask
                                          .updateMask(
                                              mask: '+7(###)###-##-##',
                                              filter: {"#": RegExp(r'[0-9]')});
                                    });
                                  }
                                });
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 14, right: 8),
                          child: Row(
                            children: [
                              Text(
                                hint,
                                style: kInterReg16ColorBDBDBD,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: kColorBDBDBD,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          inputFormatters: [textInputMask],
                          onChanged: (value) {
                            provider.setError = '';
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 0, top: 14, bottom: 14, right: 24),
                            hintText: ' ',
                            filled: false,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    provider.password = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Пароль *',
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  provider.error,
                  style: kInterReg16ColorCC6666,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () {
                      if (hint == 'Email') {
                        provider.email = textInputMask.getUnmaskedText();
                      } else {
                        provider.email = '7' + textInputMask.getUnmaskedText();
                      }

                      provider.login(onSuccess: () {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .getProfile(() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        });
                      });
                    },
                    child: provider.isRequestSend
                        ? CircularLoader()
                        : Text('Войти')),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswordScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Я забыл пароль',
                      style: kInterReg14Color2980B9,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LoginExp extends StatelessWidget {
  final Function(int) onSelected;
  const LoginExp({Key? key, required this.onSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              onSelected(1);
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                'Email',
                style: kInterReg16ColorBlack,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onSelected(2);
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Text(
                'Телефон',
                style: kInterReg16ColorBlack,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
