import 'package:budge_up/presentation/button_styles.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/views/auth/login/login_screen.dart';
import 'package:budge_up/views/auth/register/register_screen.dart';
import 'package:budge_up/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColor2980B9,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(bottom: 150),
                  alignment: Alignment.center,
                  child: kLogoIcon,
                ),
              ),
              ElevatedButton(
                style: kElevatedButtonStyle1,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Text('Вход'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: kElevatedButtonStyle2,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text('Регистрация'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
