import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:budge_up/views/components/cutom_allerts.dart';
import 'package:budge_up/views/components/time_date_item.dart';
import 'package:budge_up/views/park/park_provider.dart';
import 'package:budge_up/views/parking_auto/components.dart';
import 'package:budge_up/views/profile/profile_screen.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkScreen extends StatefulWidget {
  const ParkScreen({Key? key}) : super(key: key);

  @override
  _ParkScreenState createState() => _ParkScreenState();
}

class _ParkScreenState extends State<ParkScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ParkProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Парковки'),
        ),
        body: ParkBody(),
      ),
    );
  }
}

class ParkBody extends StatefulWidget {
  const ParkBody({Key? key}) : super(key: key);

  @override
  _ParkBodyState createState() => _ParkBodyState();
}

class _ParkBodyState extends State<ParkBody> {
  UserModel user = UserModel();
  @override
  void initState() {
    super.initState();
    user = Provider.of<SettingsProvider>(context, listen: false).user;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ParkProvider>(context, listen: false).getItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParkProvider>();
    if (provider.isRequestSend) {
      return Container(
        padding: EdgeInsets.only(top: 100),
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
      );
    }
    if (provider.results.length == 0 && provider.isViewSetup) {
      return Container(
        padding: EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        child: EmptyData(
            title:
            'Нет ни одной активной парковки'),
      );
    }
    return RefreshIndicator(
      onRefresh: () async{
        provider.getItems();
      },
      child: ListView.builder(
          itemCount: provider.results.length,
          itemBuilder: (context, index) {
            return ParkListItem(
              parkModel: provider.results[index],
              user: user,
              onArchive: (value) {
                provider.archive(value);
              },
              isLoading:
                  provider.id == provider.results[index].id && provider.isLoading,
              onPhoneChanged: (value ) {
                provider.updatePhone(value, provider.results[index]);
              },
            );
          }),
    );
  }
}


class ParkListItem extends StatelessWidget {
  final ParkModel parkModel;
  final UserModel user;
  final Function(ParkModel) onArchive;
  final bool isLoading;
  final Function(String) onPhoneChanged;

  const ParkListItem({
    Key? key,
    required this.parkModel,
    required this.user,
    required this.isLoading,
    required this.onArchive,
    required this.onPhoneChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(user.id);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(parkModel.close.id > 0)
          ParkItemClose(
            auto: parkModel.closeGarageItem,
            user: parkModel.close.user,
            text: 'Закрыт мной',
            phone: parkModel.close.phone,
            time: parkModel.close.time,
            date: parkModel.close.date,),
            ParkItemUser(onPhoneChanged:  onPhoneChanged,
              date: parkModel.date,
              auto: parkModel.garageItem,
              phone: parkModel.phone,
              user: parkModel.user,
              time: parkModel.time,),
          if(parkModel.closeMe.id > 0)
            ParkItemClose(
              auto: parkModel.closeMe.garageItem,
              user: parkModel.closeMe.user,
              text: 'Закрыл меня',
              phone: parkModel.closeMe.phone,
              time: parkModel.closeMe.time,
              date: parkModel.closeMe.date,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ParkArchiveDialog(onTap: (){
                          onArchive(parkModel);
                        },);
                      });
                },
                child: isLoading
                    ? CircularLoader()
                    : Text(parkModel.closeMe.id > 0
                    ? 'Я все равно уехал'
                    : 'Уехать')),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}


class ParkItemUser extends StatelessWidget {
  final AutoModel auto;
  final UserModel user;
  final String phone;
  final String date;
  final String time;
  final Function(String) onPhoneChanged;
  const ParkItemUser({
    Key? key,
    required this.auto,
    required this.user,
    required this.phone,
    required this.time,
    required this.date,
    required this.onPhoneChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen(user: user)));
            },
            child: AvatarItem(
                image: user.photo, height: 96, width: 96),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 60),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.name,
                      textAlign: TextAlign.center,
                      style: kInterSemiBold18,
                    ),
                    SizedBox(height: 4),
                    Text(
                      phone,
                      textAlign: TextAlign.center,
                      style: kInterReg16ColorBlack,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PhoneEditView(
                          phone: phone,
                          onTap: (value) {
                            onPhoneChanged(value);
                          },
                        );
                      });
                },
                icon: CustomIcon(
                  customIcon: CustomIcons.edit,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          AutoItem(
              auto: auto,
              onDelete: null,
              isLoading: false),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            child: TimeDateItem(
              date: date,
              time: time,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ParkItemClose extends StatelessWidget {
  final AutoModel auto;
  final UserModel user;
  final String phone;
  final String date;
  final String time;
  final String text;
  const ParkItemClose({
    Key? key,
    required this.auto,
    required this.user,
    required this.phone,
    required this.time,
    required this.date,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kColorF8F8F8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(user: user)));
                      },
                      child: AvatarItem(
                          image: user.photo, height: 96, width: 96),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 60),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                user.name,
                                textAlign: TextAlign.center,
                                style: kInterSemiBold18,
                              ),
                              SizedBox(height: 4),
                              Text(
                                phone,
                                textAlign: TextAlign.center,
                                style: kInterReg16ColorBlack,
                              ),
                            ],
                          ),
                        ),
                          IconButton(
                            onPressed: () async {
                              final Uri _emailLaunchUri = Uri(
                                scheme: 'tel',
                                path: phone,
                              );
                              String url = _emailLaunchUri.toString();
                              if (await canLaunch(url)) {
                                await launch(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            icon: CustomIcon(
                              customIcon: CustomIcons.call,
                            ),
                          ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 20),
                    AutoItem(
                        auto: auto,
                        onDelete: null,
                        isLoading: false),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: TimeDateItem(
                        date: date,
                        time: time,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                decoration: BoxDecoration(
                    color: kColorB2CC6666,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(text,
                  style: kInterReg12.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
