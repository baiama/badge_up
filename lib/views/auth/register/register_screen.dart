import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/auth/register/register_provider.dart';
import 'package:budge_up/views/home/home_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegisterProvider(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CustomBackButton(),
          title: Text('Регистрация'),
        ),
        body: RegisterBody(),
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  const RegisterBody({Key? key}) : super(key: key);

  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  void _open() async {
    var url = 'https://budgeup.ru/privacy_policy.html';
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  var textInputMask = MaskTextInputFormatter(
      mask: '+7(###)###-##-##', filter: {"#": RegExp(r'[0-9]')});

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
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(24),
          child: Consumer<RegisterProvider>(
            builder: (context, provider, Widget? child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (value) {
                      provider.name = value;
                      provider.setError = '';
                    },
                    decoration: InputDecoration(
                      hintText: 'Имя *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    onChanged: (value) {
                      provider.setError = '';
                    },
                    inputFormatters: [textInputMask],
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Телефон *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    onChanged: (value) {
                      provider.email = value;
                      provider.setError = '';
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      provider.password = value;
                      provider.setError = '';
                    },
                    decoration: InputDecoration(
                      hintText: 'Пароль *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      provider.passwordRepeat = value;
                      provider.setError = '';
                    },
                    decoration: InputDecoration(
                      hintText: 'Пароль еще раз *',
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    provider.error,
                    style: kInterReg16ColorCC6666,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        provider.phone = textInputMask.getUnmaskedText();
                        provider.register(onSuccess: () {
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
                          : Text('Зарегистрироваться')),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _open();
                    },
                    child: Container(
                      padding: EdgeInsets.all(14),
                      color: Colors.white,
                      child: Text(
                        'Нажав на «Зарегистрироваться», вы соглашаетесь с условиями пользования',
                        style: kInterReg14Color2980B9,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
