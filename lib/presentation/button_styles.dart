import 'package:budge_up/presentation/color_scheme.dart';
import 'package:budge_up/presentation/text_styles.dart';
import 'package:flutter/material.dart';

var kElevatedButtonStyle1 = ButtonStyle(
  elevation: MaterialStateProperty.all(1.0),
  minimumSize: MaterialStateProperty.all(Size(120, 48)),
  textStyle: MaterialStateProperty.all(kInterSemiBold16ColorWhite),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(kColor0D4E78),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    ),
  ),
);

var kElevatedButtonStyle2 = ButtonStyle(
  elevation: MaterialStateProperty.all(1.0),
  minimumSize: MaterialStateProperty.all(Size(120, 48)),
  textStyle: MaterialStateProperty.all(kInterSemiBold16ColorWhite),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(kColor2980B9),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      side: BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    ),
  ),
);

var kElevatedButtonStyle3 = ButtonStyle(
  elevation: MaterialStateProperty.all(1.0),
  minimumSize: MaterialStateProperty.all(Size(120, 48)),
  textStyle: MaterialStateProperty.all(kInterSemiBold16ColorWhite),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(kColor2980B9),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    ),
  ),
);


var kAlertElevatedButtonStyle = ButtonStyle(
  minimumSize: MaterialStateProperty.all(Size(20, 30)),
  textStyle: MaterialStateProperty.all(kInterSemiBold16ColorWhite),
  foregroundColor: MaterialStateProperty.all(Colors.white),
  backgroundColor: MaterialStateProperty.all(kColor2980B9),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
    ),
  ),
);