import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/cutom_allerts.dart';
import 'package:budge_up/views/initial/initial_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:budge_up/views/settings/widgets/code_widget.dart';
import 'package:budge_up/views/settings/widgets/profile_image_container.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Provider.of<SettingsProvider>(context, listen: false).getProfile(() {
        textController.text =
            Provider.of<SettingsProvider>(context, listen: false)
                .user
                .unMaskedPhone;
      });
      Provider.of<SettingsProvider>(context, listen: false).setUp();
      Provider.of<SettingsProvider>(context, listen: false).setUpSettings();
    });
  }

  var textController = MaskedTextController(
      mask: '(###) ###-##-##', translator: {"#": RegExp(r'[0-9]')});

  final _formKey = GlobalKey<FormState>();

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
                  if (provider.isRequestSend) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 100),
                      child: CircularLoader(),
                    );
                  }

                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
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
                          maxLength: 50,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-zа-яА-Я0-9 ]')),
                          ],
                          initialValue: provider.user.name,
                          onChanged: (value) {
                            provider.name = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Имя *',
                          ),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return Strings.errorEmpty;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // TextFormField(
                        //   controller: textController,
                        //   keyboardType: TextInputType.phone,
                        //   onChanged: (value) {
                        //     provider.phone = value;
                        //   },
                        //   decoration: InputDecoration(
                        //     hintText: 'Телефон *',
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.length == 0) {
                        //       return Strings.errorEmpty;
                        //     }
                        //     return null;
                        //   },
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              color: kColorF6F6F6,
                              border: Border.all(color: kColorE8E8E8),
                              borderRadius: BorderRadius.circular(100)),
                          child: Row(
                            children: [
                              SizedBox(width: 12),
                              Text(
                                '+7',
                                style: kInterReg16ColorBlack,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: textController,
                                  // inputFormatters: [maskFormatter],
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    provider.phone = value;
                                  },
                                  validator: (value) {
                                    // if (value == null || value.length == 0) {
                                    //   return Strings.errorEmpty;
                                    // }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 0,
                                        top: 14,
                                        bottom: 14,
                                        right: 24),
                                    hintText: 'Телефон',
                                    filled: false,
                                    border: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (textController.unmasked.isEmpty)
                          Container(
                            padding: EdgeInsets.only(top: 5, left: 17),
                            child: Text(
                              Strings.errorEmpty,
                              style:
                                  TextStyle(fontSize: 12, color: kColorCC6666),
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
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return Strings.errorEmpty;
                            }
                            return null;
                          },
                        ),
                        if (!provider.user.isEmailConfirm) SizedBox(height: 20),
                        if (!provider.user.isEmailConfirm)
                          CodeWidget(
                            onCodeTap: () {
                              provider.setError2 = '';
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CodeView();
                                },
                              );
                            },
                            onResendTap: () {
                              provider.resendCode(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'Код отправлен на вашу почту.',
                                      style: kInterReg16ColorBlack,
                                    ),
                                  ),
                                );
                              }, (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      value,
                                      style: kInterReg16ColorBlack,
                                    ),
                                  ),
                                );
                              });
                            },
                            confirmed: provider.user.isEmailConfirm,
                          ),
                        SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            provider.password = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Пароль',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLength: 200,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-zа-яА-Я0-9!”№;%:?*()_+. ]')),
                          ],
                          initialValue: provider.user.desc,
                          onChanged: (value) {
                            provider.aboutMe = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Здесь написано обо мне',
                          ),
                          validator: (value) {
                            // if (value == null || value.length == 0) {
                            //   return Strings.errorEmpty;
                            // }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Switch(
                                inactiveTrackColor: kColor2980B9,
                                value: provider.user.isSendPush,
                                onChanged: (value) {
                                  provider.user.isSendPush = value;
                                  provider.updateView();
                                }),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Получать PUSH уведомления',
                                style: kInterReg16ColorCC6666.copyWith(
                                  color: kColor666666,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (provider.error.length > 0) SizedBox(height: 20),
                        if (provider.error.length > 0)
                          Text(
                            provider.error,
                            style: kInterReg16ColorCC6666,
                            textAlign: TextAlign.center,
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  !_formKey.currentState!.validate()) {
                                return;
                              }
                              provider.phone = textController.unmasked;
                              provider.updateProfile(onSuccess: () {
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      'Данные успешно обновлены.',
                                      style: kInterReg16ColorBlack,
                                    ),
                                  ),
                                );
                              }, onFailure: (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.white,
                                    content: Text(
                                      value,
                                      style: kInterReg16ColorBlack,
                                    ),
                                  ),
                                );
                              });
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
