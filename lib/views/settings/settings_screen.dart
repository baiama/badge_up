import 'package:budge_up/presentation/custom_icons.dart';
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
    );
  }
}
