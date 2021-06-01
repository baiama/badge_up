import 'package:budge_up/api/auth_api.dart';
import 'package:budge_up/presentation/button_styles.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/utils/preference_helper.dart';
import 'package:budge_up/views/auth/login/login_screen.dart';
import 'package:budge_up/views/auth/register/register_screen.dart';
import 'package:budge_up/views/home/home_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isAuthorized = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkToken();
    });
  }

  void checkToken() async {
    String token = await PreferenceHelper().token;
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (token.length > 0) {
        Duration tokenTime = JwtDecoder.getRemainingTime(token);
        if (tokenTime.inDays < 2) {
          AuthApi().refreshToken(onSuccess: () {
            Provider.of<SettingsProvider>(context, listen: false).getProfile();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false);
          }, onFailure: () {
            setState(() {
              isAuthorized = false;
            });
          });
        } else {
          Provider.of<SettingsProvider>(context, listen: false).getProfile();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
        }
      } else {
        setState(() {
          isAuthorized = false;
        });
      }
    });
  }

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
                  child: CustomIcon(
                    customIcon: CustomIcons.logo,
                  ),
                ),
              ),
              if (!isAuthorized)
                ElevatedButton(
                  style: kElevatedButtonStyle1,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text('Вход'),
                ),
              SizedBox(height: 24),
              if (!isAuthorized)
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
