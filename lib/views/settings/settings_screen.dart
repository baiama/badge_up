import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/cutom_allerts.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:budge_up/views/settings/widgets/profile_image_container.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
      Provider.of<SettingsProvider>(context, listen: false).setUp();
      Provider.of<SettingsProvider>(context, listen: false).setUpSettings();
    });
  }

  var textInputMask = MaskTextInputFormatter(
      mask: '+7(###)###-##-##', filter: {"#": RegExp(r'[0-9]')});

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
                builder: (context, provider, child) {
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
                        SizedBox(height: 16),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            provider.user.name,
                            style:
                                kInterSemiBold18.copyWith(color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 35),
                        TextFormField(
                          initialValue: provider.user.name,
                          onChanged: (value) {
                            provider.name = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Имя *',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          inputFormatters: [textInputMask],
                          initialValue: textInputMask
                              .maskText(provider.user.unMaskedPhone),
                          onChanged: (value) {
                            provider.phone = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Телефон *',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: provider.user.email,
                          onChanged: (value) {
                            provider.email = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email *',
                          ),
                        ),
                        if (!provider.user.isEmailConfirm) SizedBox(height: 20),
                        if (!provider.user.isEmailConfirm)
                          TextFormField(
                            onChanged: (value) {
                              provider.code = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Код подтверждения',
                              hintStyle: kInterReg16ColorCC6666,
                            ),
                          ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            provider.password = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Пароль *',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          initialValue: provider.user.desc,
                          onChanged: (value) {
                            provider.aboutMe = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Здесь написано обо мне',
                          ),
                        ),
                        SizedBox(height: 20),
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
