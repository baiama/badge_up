import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/views/components/auto_item.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:budge_up/views/components/time_date_item.dart';
import 'package:budge_up/views/park/park_provider.dart';
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
    return ListView.builder(
        itemCount: provider.results.length,
        itemBuilder: (context, index) {
          return ParkItem(
            parkModel: provider.results[index],
            user: user,
          );
        });
  }
}

class ParkItem extends StatelessWidget {
  final ParkModel parkModel;
  final UserModel user;
  const ParkItem({Key? key, required this.parkModel, required this.user})
      : super(key: key);

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
                  color: parkModel.close.id > 0
                      ? kColorF8F8F8
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24),
                    AvatarItem(
                        image: parkModel.user.photo, height: 96, width: 96),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 40),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                parkModel.user.name,
                                textAlign: TextAlign.center,
                                style: kInterSemiBold18,
                              ),
                              SizedBox(height: 4),
                              Text(
                                parkModel.user.phone,
                                textAlign: TextAlign.center,
                                style: kInterReg16ColorBlack,
                              ),
                            ],
                          ),
                        ),
                        if (parkModel.close.id == 0) SizedBox(width: 40),
                        if (parkModel.close.id > 0)
                          IconButton(
                            onPressed: () async {
                              final Uri _emailLaunchUri = Uri(
                                scheme: 'tel',
                                path: parkModel.user.phone,
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
                      ],
                    ),
                    SizedBox(height: 20),
                    AutoItem(
                        auto: parkModel.garageItem,
                        onDelete: null,
                        isLoading: false),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.center,
                      child: TimeDateItem(
                        date: parkModel.date,
                        time: parkModel.time,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 24),
              if (parkModel.active)
                ElevatedButton(
                    onPressed: () {},
                    child: Text(parkModel.close.id > 0 &&
                            parkModel.close.userId != user.id
                        ? 'Я все равно уехал'
                        : 'Уехать')),
              SizedBox(height: 12),
            ],
          ),
          if (parkModel.close.id > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                decoration: BoxDecoration(
                    color: kColorB2CC6666,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  parkModel.close.userId == user.id
                      ? 'Закрыт мной'
                      : 'Закрыл меня',
                  style: kInterReg12.copyWith(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
