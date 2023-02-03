import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBackgroundLight = Color(0xffffeade);
  static const Color scaffoldBackgroundDark = Color(0xff290f00);

  static const int primaryLightHex = 0xffff9559;
  static const int primaryDarkHex = 0xff7a2c00;

  static const Color primaryLight = Color(0xffff9559);
  static const Color primaryDark = Color(0xff7a2c00);

  static const Color labelDark = Color(0xffa23b00);

  static const MaterialColor primarySwatchLight = MaterialColor(
    primaryLightHex, //0%
    <int, Color>{
      50: Color(0xffffa06a), //10%
      100: Color(0xffffaa7a), //20%
      200: Color(0xffffb58b), //30%
      300: Color(0xffffbf9b), //40%
      400: Color(0xffffcaac), //50%
      500: Color(0xffffd5bd), //60%
      600: Color(0xffffdfcd), //70%
      700: Color(0xffffeade), //80%
      800: Color(0xfffff4ee), //90%
      900: Color(0xffffffff), //100%
    },
  );
  static const MaterialColor primarySwatchDark = MaterialColor(
    primaryDarkHex, //0%
    <int, Color>{
      50: Color(0xffb74300), //10%
      100: Color(0xffa23b00), //20%
      200: Color(0xff8e3400), //30%
      300: Color(0xff7a2c00), //40%
      400: Color(0xff662500), //50%
      500: Color(0xff511e00), //60%
      600: Color(0xff3d1600), //70%
      700: Color(0xff290f00), //80%
      800: Color(0xff140700), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const Color hintColorLight = Color(0xff9c9c9c);
  static Color hintColorDark = const Color(0xffffffff).withAlpha(70);

  static Color btnDisabledLight = Colors.brown.withAlpha(60);
  static Color btnDisabledDark = Colors.white.withAlpha(70);

  static Color textDisabledLight = Colors.grey.shade200;
  static Color textDisabledDark = Colors.grey.shade600;
}
