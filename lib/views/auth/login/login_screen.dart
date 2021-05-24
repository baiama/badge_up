import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/auth/login/login_provider.dart';
import 'package:budge_up/views/auth/reset_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: Text('Авторизация'),
      ),
      body: GestureDetector(
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
                  TextFormField(
                    onChanged: (value) {
                      provider.email = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Телефон или Email *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
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
                  ElevatedButton(onPressed: () {}, child: Text('Войти')),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordScreen()));
                      print(result);
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
      ),
    );
  }
}
