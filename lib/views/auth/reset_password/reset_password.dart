import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: Text('Я забыл пароль'),
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
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(24),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 25),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email *',
                  ),
                ),
                SizedBox(height: 26),
                Text(
                  'Некорректное заполнение: Email',
                  style: kInterReg16ColorCC6666,
                  textAlign: TextAlign.center,
                ),
                Expanded(child: Container()),
                ElevatedButton(
                    onPressed: () {}, child: Text('Восстановить пароль')),
                SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
