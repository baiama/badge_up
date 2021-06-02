import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: Text('Профиль'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            AvatarItem(image: user.photo, height: 123, width: 123),
            SizedBox(height: 30),
            Text(
              user.name,
              textAlign: TextAlign.center,
              style: kInterSemiBold18,
            ),
            SizedBox(height: 4),
            Text(
              user.phone,
              textAlign: TextAlign.center,
              style: kInterReg16ColorBlack,
            ),
            SizedBox(height: 28),
            if (user.description.length > 0)
              Text(
                user.description,
                textAlign: TextAlign.center,
                style: kInterReg16ColorBlack.copyWith(color: kColor999999),
              ),
          ],
        ),
      ),
    );
  }
}
