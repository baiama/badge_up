import 'dart:ui';

import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

class NotificationBody extends StatelessWidget {
  final String? title;
  final String? body;
  NotificationBody({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 12,
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: kColor2980B9,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  width: 1.4,
                  color: kColor2980B9.withOpacity(0.2),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      title != null ? title! : '',
                      textAlign: TextAlign.center,
                      style: kInterReg16ColorBlack.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      body != null ? body! : '',
                      textAlign: TextAlign.center,
                      style: kInterReg16ColorBlack.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
