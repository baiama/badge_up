import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/views/garage/garage_screen.dart';
import 'package:budge_up/views/park/park_screen.dart';
import 'package:budge_up/views/parking_auto/parking_auto.dart';
import 'package:budge_up/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final _screens = [];

  BottomNavigationBarItem getNavItem(String item, String label) {
    return BottomNavigationBarItem(
        icon: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 2, bottom: 4),
          child: CustomIcon(
            customIcon: item,
          ),
        ),
        activeIcon: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 2, bottom: 2),
            child: CustomIcon(
              customIcon: item,
              color: kColor666666,
            )),
        label: label);
  }

  @override
  void initState() {
    super.initState();
    _screens.add(
      ParkingAuto(
        onPark: () {
          setState(() {
            _index = 1;
          });
        },
      ),
    );
    _screens.add(
      ParkScreen(),
    );
    _screens.add(
      GarageScreen(),
    );
    _screens.add(
      SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kColorFAFAFA,
        selectedItemColor: kColor666666,
        unselectedItemColor: kColorCCCCCC,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        unselectedLabelStyle: kInterReg10.copyWith(color: kColorCCCCCC),
        selectedLabelStyle: kInterReg10.copyWith(color: kColor666666),
        items: [
          getNavItem(CustomIcons.parking, 'Парковаться'),
          getNavItem(CustomIcons.park, 'Парковки'),
          getNavItem(CustomIcons.taxi, 'Гараж'),
          getNavItem(CustomIcons.settings, 'Настройки'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
