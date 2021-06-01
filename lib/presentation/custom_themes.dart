import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

import 'button_styles.dart';

const kAppBarTheme = AppBarTheme(
  centerTitle: true,
  color: Colors.white,
  elevation: 0.0,
  brightness: Brightness.light,
  iconTheme: IconThemeData(
    color: kColor2980B9,
  ),
  textTheme: TextTheme(headline6: kInterSemiBold24ColorBlack),
);

const kInputDecorationBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(100),
  ),
  borderSide: BorderSide(
    color: kColorE8E8E8,
  ),
);
const kInputDecorationBorder2 = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(100),
  ),
  borderSide: BorderSide(
    color: Colors.transparent,
  ),
);

const kInputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: kColorF6F6F6,
  contentPadding: EdgeInsets.only(left: 24, top: 14, bottom: 14, right: 24),
  labelStyle: kInterReg16ColorBlack,
  hintStyle: kInterReg16ColorBDBDBD,
  focusedBorder: kInputDecorationBorder,
  disabledBorder: kInputDecorationBorder,
  errorMaxLines: 4,
  errorBorder: kInputDecorationBorder,
  enabledBorder: kInputDecorationBorder,
  focusedErrorBorder: kInputDecorationBorder,
  border: kInputDecorationBorder,
);

var kElevationButtonTheme = ElevatedButtonThemeData(
  style: kElevatedButtonStyle3,
);
