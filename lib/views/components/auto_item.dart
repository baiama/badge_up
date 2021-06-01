import 'package:budge_up/models/auto_model.dart';
import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/custom_icons.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:budge_up/presentation/widgets.dart';
import 'package:flutter/material.dart';

class AutoItem extends StatelessWidget {
  final AutoModel auto;
  final Function(int) onDelete;
  final bool isLoading;
  const AutoItem(
      {Key? key,
      required this.auto,
      required this.onDelete,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32, left: 26, right: 26),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 40),
              Expanded(
                child: Text(
                  auto.type,
                  style: kInterBold18,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: () {
                  onDelete(auto.id);
                },
                icon: isLoading
                    ? CircularLoader()
                    : CustomIcon(
                        customIcon: CustomIcons.remove,
                      ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
                color: kColor4D7EB7DC, borderRadius: BorderRadius.circular(8)),
            child: Text(
              auto.number,
              style: kInterReg16ColorBlack,
            ),
          ),
        ],
      ),
    );
  }
}
