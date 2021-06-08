import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

class TimeDateItem extends StatelessWidget {
  final String time;
  final String date;

  const TimeDateItem({Key? key, required this.time, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kColor4D7BE2B0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(customIcon: CustomIcons.clock),
          SizedBox(width: 5),
          Text(time, style: kInterReg16ColorBlack),
          SizedBox(width: 8),
          CustomIcon(customIcon: CustomIcons.calendar),
          SizedBox(width: 5),
          Text(date, style: kInterReg16ColorBlack),
        ],
      ),
    );
  }
}
