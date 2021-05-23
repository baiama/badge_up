import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
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
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Имя *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Телефон *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Пароль *',
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Пароль еще раз *',
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Некорректное заполнение: Телефон',
                    style: kInterReg16ColorCC6666,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 130,
                  ),
                  ElevatedButton(
                      onPressed: () {}, child: Text('Зарегистрироваться')),
                  SizedBox(height: 24),
                  Text(
                    'Нажав на «Зарегистрироваться», вы соглашаетесь с условиями пользования',
                    style: kInterReg14Color2980B9,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
