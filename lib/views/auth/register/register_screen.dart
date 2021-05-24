import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/auth/register/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegisterProvider>(context, listen: false).setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: Text('Регистрация'),
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
                      },
                      decoration: InputDecoration(
                        hintText: 'Имя *',
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      onChanged: (value) {
                        provider.phone = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Телефон *',
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      onChanged: (value) {
                        provider.email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email *',
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
                    TextFormField(
                      onChanged: (value) {
                        provider.passwordRepeat = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Пароль еще раз *',
                      ),
                    ),
                    SizedBox(height: 24),
                    if (provider.error.length > 0)
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
                          provider.register(onSuccess: () {});
                        },
                        child: Text('Зарегистрироваться')),
                    SizedBox(height: 24),
                    Text(
                      'Нажав на «Зарегистрироваться», вы соглашаетесь с условиями пользования',
                      style: kInterReg14Color2980B9,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
