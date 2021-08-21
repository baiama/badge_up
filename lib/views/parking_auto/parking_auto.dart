import 'package:budge_up/api/settings_api.dart';
import 'package:budge_up/models/month_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/custom_themes.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/utils/preference_helper.dart';
import 'package:budge_up/utils/strings.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/components/notification_body.dart';
import 'package:budge_up/views/garage/garage_add_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto_provider.dart';
import 'package:budge_up/views/parking_auto/scanner_screen.dart';
import 'package:budge_up/views/parking_auto/search_result.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import 'components.dart';

class ParkingAuto extends StatefulWidget {
  final Function onPark;
  const ParkingAuto({Key? key, required this.onPark}) : super(key: key);

  @override
  _ParkingAutoState createState() => _ParkingAutoState();
}

class _ParkingAutoState extends State<ParkingAuto> {
  late ParkingAutoProvider currentProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      currentProvider =
          Provider.of<ParkingAutoProvider>(context, listen: false);
      currentProvider.getItems();
      currentProvider.setPhone =
          Provider.of<SettingsProvider>(context, listen: false).user.phone;
      _initPushes();
    });
  }

  void _initPushes() async {
    FlutterAppBadger.removeBadge();

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null && value.length > 0) {
        safeToken(value);
      }
    });
    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      if (token.length > 0) {
        safeToken(token);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null && value.notification != null) {
        _navigate(value);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        _navigate(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showNotification(message);
      }
    });
  }

  void safeToken(String token) async {
    var helper = PreferenceHelper();
    var oldToken = await helper.fcmToken;
    if (oldToken != token) {
      SettingsApi().saveToken(token: token);
      helper.setFcmToken(token: token);
    }
  }

  void _navigate(RemoteMessage? message) {
    widget.onPark();
  }

  void _showNotification(RemoteMessage message) {
    if (message.notification != null) {
      InAppNotification.show(
        child: NotificationBody(
          body: message.notification!.body,
          title: message.notification!.title,
        ),
        context: context,
        duration: Duration(seconds: 4),
        onTap: () => _navigate(message),
      );
    }
  }

  var numMaskFormatter = new MaskTextInputFormatter(
      mask: '# *** ## ***',
      filter: {"#": RegExp("[а-яА-Я]"), "*": RegExp("[0-9]")});

  var autoNumController = TextEditingController();

  void _selectDate() {
    final now = DateTime.now();
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: now,
        theme: DatePickerTheme(
          backgroundColor: Colors.white,
        ),
        maxTime: DateTime(2050, 6, 7), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      currentProvider.setDate(date);
    },
        currentTime: DateTime.utc(
            currentProvider.year, currentProvider.month, currentProvider.day),
        locale: LocaleType.ru);
  }

  void _selectTime() {
    DatePicker.showTimePicker(context, showSecondsColumn: false,
        onConfirm: (date) {
      currentProvider.setTime(date);
    },
        currentTime: DateTime.utc(currentProvider.year, currentProvider.month,
            currentProvider.day, currentProvider.hour, currentProvider.min),
        locale: LocaleType.ru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Парковать авто'),
      ),
      body: Container(
        child: Consumer<ParkingAutoProvider>(
          builder: (context, provider, Widget? child) {
            if (provider.isRequestSend) {
              return Container(
                padding: EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (!provider.isViewSetup) {
              return Container();
            }

            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30),
                    if (provider.items.length > 0)
                      AutoItem(
                          auto: provider.selectedAuto,
                          onDelete: null,
                          isLoading: false),
                    if (provider.items.length > 0)
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AutoListView(
                                  onTap: (value) {
                                    provider.setSelectedAuto = value;
                                  },
                                  selectedAuto: provider.selectedAuto,
                                );
                              });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                          child: Text(
                            'Выбрать другой авто',
                            style: kInterReg16ColorCC6666.copyWith(
                              color: kColor2980B9,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    if (provider.items.length == 0)
                      EmptyCar(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GarageAddScreen()),
                          ).then((value) {
                            Provider.of<ParkingAutoProvider>(context,
                                    listen: false)
                                .getItems();
                          });
                        },
                      ),
                    SizedBox(height: 25),
                    PhoneView(
                      phone: provider.phone,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return PhoneEditView(
                                phone: provider.phone,
                                onTap: (value) {
                                  provider.setPhone = value;
                                },
                              );
                            });
                      },
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Я закрываю авто (опционально):',
                      textAlign: TextAlign.center,
                      style: kInterBold16,
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                border: Border.all(
                                  color: kColorE8E8E8,
                                  width: 2,
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    inputFormatters: [numMaskFormatter],
                                    controller: autoNumController,
                                    onChanged: (value) {
                                      provider.number =
                                          numMaskFormatter.getUnmaskedText();
                                      provider.setClosePark2 = null;
                                      provider.updateView();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: kInputDecorationBorder2,
                                      errorBorder: kInputDecorationBorder2,
                                      focusedBorder: kInputDecorationBorder2,
                                      focusedErrorBorder:
                                          kInputDecorationBorder2,
                                      disabledBorder: kInputDecorationBorder2,
                                      enabledBorder: kInputDecorationBorder2,
                                      hintText: 'А 777 АА 777',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () async {
                                      String? plate = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ScannerScreen()));
                                      print(plate);
                                      if (plate != null) {
                                        autoNumController.text = plate;
                                        provider.number = plate;
                                        provider.updateView();
                                      }
                                    },
                                    child: Container(
                                        padding:
                                            EdgeInsets.only(right: 12, left: 8),
                                        child: CustomIcon(
                                            customIcon: CustomIcons.scanner))),
                              ],
                            ),
                          ),
                        ),
                        if (provider.number.length > 2) SizedBox(width: 18),
                        if (provider.number.length > 2)
                          ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SearchResult(query: provider.number),
                                  ),
                                ).then((value) {
                                  if (value != null && value == 'selected') {
                                    autoNumController.text =
                                        provider.closePark.garageItem.number;
                                  }
                                });
                              },
                              child: Text('Найти')),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (provider.closePark.id > 0 || provider.isOk)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Выбран авто: ${provider.getCurrentNumber}',
                            style: kInterReg16ColorBlack,
                          ),
                          IconButton(
                            onPressed: () {
                              provider.removeSelectedAuto();
                            },
                            icon: CustomIcon(
                              customIcon: CustomIcons.remove,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 30),
                    Text(
                      'Когда вы планируете уехать?',
                      style: kInterBold16,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 27),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: DateLabel(
                            onTap: () {
                              _selectDate();
                            },
                            title: provider.day.toString(),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 4,
                          child: DateLabel(
                            title: MonthModel.monthShort[provider.month - 1],
                            onTap: () {
                              _selectDate();
                              // showDialog(
                              //     context: context,
                              //     builder: (context) {
                              //       return MonthListView(
                              //         onSelected: (value) {
                              //           provider.month = value;
                              //           provider.updateView();
                              //         },
                              //       );
                              //     });
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 5,
                          child: DateLabel(
                            onTap: () {
                              _selectDate();
                            },
                            title: provider.year.toString(),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                            flex: 5,
                            child: DateLabel(
                              onTap: () {
                                _selectTime();
                              },
                              title: provider.time,
                            )),
                      ],
                    ),
                    SizedBox(height: 27),
                    Text(
                      'Местное время',
                      style:
                          kInterReg16ColorBDBDBD.copyWith(color: kColor999999),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return kColorCCCCCC;
                              }
                              return kColor2980B9;
                            }),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.zero)),
                        onPressed: provider.buttonIsEnabled
                            ? () {
                                provider.create(onSuccess: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.white,
                                      content: Text(
                                        Strings.successCreatePark,
                                        style: kInterReg16ColorBlack,
                                      ),
                                    ),
                                  );
                                  widget.onPark();
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
                              }
                            : null,
                        child: provider.isCreating
                            ? CircularLoader()
                            : Text('Парковаться')),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
