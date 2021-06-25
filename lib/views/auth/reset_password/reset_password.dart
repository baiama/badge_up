import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/auth/reset_password/reset_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ResetPasswordProvider(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: CustomBackButton(),
          title: Text('Я забыл пароль'),
        ),
        body: ResetPasswordBody(),
      ),
    );
  }
}

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({Key? key}) : super(key: key);

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
      child: Consumer<ResetPasswordProvider>(
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
                    hintText: 'Email *',
                  ),
                ),
                SizedBox(height: 26),
                Text(
                  provider.error,
                  style: kInterReg16ColorCC6666,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () {
                      provider.resetPassword(onSuccess: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.white,
                            duration: Duration(seconds: 3),
                            content: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                'Новый пароль отправлен на почту',
                                style: kInterReg16ColorCC6666.copyWith(
                                    color: Colors.green),
                              ),
                            )));
                        Future.delayed(Duration(seconds: 3)).then((value) {
                          Navigator.pop(context, 'yes');
                        });
                      });
                    },
                    child: provider.isRequestSend
                        ? CircularLoader()
                        : Text('Восстановить пароль')),
                SizedBox(height: 70),
              ],
            ),
          );
        },
      ),
    );
  }
}
