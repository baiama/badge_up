import 'package:budge_up/models/park_model.dart';
import 'package:budge_up/models/user_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/views/components/avatar_item.dart';
import 'package:budge_up/views/park/park_provider.dart';
import 'package:budge_up/views/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: kColorF8F8F8, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24),
          AvatarItem(image: parkModel.user.photo, height: 96, width: 96),
        ],
      ),
    );
  }
}
