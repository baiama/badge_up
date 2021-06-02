import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:budge_up/views/park/park_provider.dart';
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
  @override
  void initState() {
    super.initState();
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
          );
        });
  }
}

class ParkItem extends StatelessWidget {
  final ParkModel parkModel;
  const ParkItem({Key? key, required this.parkModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: parkModel.close.id > 0 ? kColorF8F8F8 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24),
          AvatarItem(image: parkModel.user.photo, height: 96, width: 96),
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
          )
        ],
      ),
    );
  }
}
