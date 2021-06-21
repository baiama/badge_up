import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/cutom_allerts.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:budge_up/views/settings/widgets/profile_image_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<SettingsProvider>(context, listen: false).getProfile(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SingOutDialog(
                      onTap: () {
                        Provider.of<SettingsProvider>(context, listen: false)
                            .logout(() {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InitialScreen()),
                              (route) => false);
                        });
                      },
                    );
                  });
            },
            icon: CustomIcon(
              customIcon: CustomIcons.logout,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Provider.of<SettingsProvider>(context, listen: false)
              .getProfile(() {});
        },
        child: GestureDetector(
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
              child: Consumer<SettingsProvider>(
                builder: (context, provider, Widget? child) {
                  return Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileImageContainer(
                          avatar: provider.user.photo,
                          image: provider.image,
                          onImageSelected: (value) {
                            provider.image = value;
                            provider.updateView();
                          },
                          imageProvider: provider.currentImage,
                        ),
                        SizedBox(height: 24),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            provider.user.name,
                            style:
                                kInterSemiBold18.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 50),
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
                              provider.updateProfile(onSuccess: () {});
                            },
                            child: provider.isLoading
                                ? CircularLoader()
                                : Text(Strings.save)),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
