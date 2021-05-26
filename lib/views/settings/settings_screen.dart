import 'package:budge_up/components/alerts.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/full_screen.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
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
      Provider.of<SettingsProvider>(context, listen: false).getProfile();
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
              Provider.of<SettingsProvider>(context, listen: false).logout(() {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => InitialScreen()),
                    (route) => false);
              });
            },
            icon: CustomIcon(
              customIcon: CustomIcons.logout,
            ),
          ),
        ],
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
            child: Consumer<SettingsProvider>(
              builder: (context, provider, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 26),
                    if (provider.image == null &&
                        provider.user.photo.length == 0)
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return ImageAlert(
                                    onImageSelected: (image) {
                                      provider.image = image;
                                      provider.updateView();
                                    },
                                  );
                                });
                          },
                          child: Container(
                            height: 120,
                            width: 120,
                            alignment: Alignment.center,
                            child: CustomIcon(
                              customIcon: CustomIcons.addPhoto,
                            ),
                            decoration: BoxDecoration(
                              color: kColorF6F6F6,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: kColor26656565,
                                  spreadRadius: 4,
                                  blurRadius: 20,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (provider.image != null ||
                        provider.user.photo.length > 0)
                      Container(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreenImage(
                                            provider.user.photo,
                                            provider.image)));
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: kColorF6F6F6,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: provider.currentImage,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kColor26656565,
                                      spreadRadius: 20,
                                      blurRadius: 20,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                icon: CustomIcon(
                                  color: Colors.grey,
                                  customIcon: CustomIcons.addPhoto,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return ImageAlert(
                                          onImageSelected: (image) {
                                            provider.image = image;
                                            provider.updateView();
                                          },
                                        );
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 24),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        provider.user.name,
                        style: kInterSemiBold18.copyWith(color: Colors.black),
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
                          // provider.register(onSuccess: () {
                          //   Navigator.pushAndRemoveUntil(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => HomeScreen()),
                          //           (route) => false);
                          // });
                        },
                        child: provider.isRequestSend
                            ? CircularLoader()
                            : Text(Strings.save)),
                    SizedBox(height: 10),
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
