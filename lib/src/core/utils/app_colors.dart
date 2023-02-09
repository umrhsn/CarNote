import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBackgroundLight = Color(0xffffeade);
  static const Color scaffoldBackgroundDark = Color(0xff290f00);

  static const int primaryLightHex = 0xffff9559;
  static const int primaryDarkHex = 0xff7a2c00;

  static const Color primaryLight = Color(0xffff9559);
  static const Color primaryDark = Color(0xff7a2c00);

  static Color appBarTextFieldFillLight = Colors.white.withAlpha(40);
  static Color appBarTextFieldFillDark = Colors.white.withAlpha(30);

  static Color appBarFocusedPrimaryLight = Colors.orange.shade900;
  static Color appBarFocusedPrimaryDark = Colors.white70;
  static Color appBarPrimaryLight = AppColors.primarySwatchLight.shade400;
  static Color appBarPrimaryDark = AppColors.primarySwatchDark.shade300;

  static Color getAppBarTextFieldBorderAndLabelFocused(BuildContext context) {
    return context.isLight
        ? AppColors.appBarFocusedPrimaryLight
        : AppColors.appBarFocusedPrimaryDark;
  }

  static Color getAppBarTextFieldBorderAndLabel(BuildContext context) {
    return context.isLight ? AppColors.appBarPrimaryLight : AppColors.appBarPrimaryDark;
  }

  static Color getTextFieldBorderAndLabelFocused(BuildContext context) {
    return context.isLight
        ? AppColors.primaryLight
        : AppColors.floatingLabelDark;
  }

  static Color getTextFieldBorderAndLabel(BuildContext context) {
    return context.isLight
        ? AppColors.hintLight
        : AppColors.hintDark;
  }

  static Color floatingLabelDark = primarySwatchDark.shade200;

  static const MaterialColor primarySwatchLight = MaterialColor(
    primaryLightHex, //0%
    <int, Color>{
      50: Color(0xffe68650), //10%
      100: Color(0xffcc7747), //20%
      200: Color(0xffb3683e), //30%
      300: Color(0xff995935), //40%
      400: Color(0xff804b2d), //50%
      500: Color(0xff663c24), //60%
      600: Color(0xff4c2d1b), //70%
      700: Color(0xff331e12), //80%
      800: Color(0xff190f09), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor primarySwatchDark = MaterialColor(
    primaryDarkHex, //0%
    <int, Color>{
      50: Color(0xff87411a), //10%
      100: Color(0xff955633), //20%
      200: Color(0xffa26b4d), //30%
      300: Color(0xffaf8066), //40%
      400: Color(0xffbd9680), //50%
      500: Color(0xffcaab99), //60%
      600: Color(0xffd7c0b3), //70%
      700: Color(0xffe4d5cc), //80%
      800: Color(0xfff2eae6), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static const Color hintLight = Color(0xff9c9c9c);
  static Color hintDark = const Color(0xffffffff).withAlpha(70);

  static Color btnDisabledLight = Colors.brown.withAlpha(60);
  static Color btnDisabledDark = Colors.white.withAlpha(70);

  static Color textDisabledLight = Colors.grey.shade200;
  static Color textDisabledDark = Colors.grey.shade600;

  static const Color errorLight = Color(0xffd40000);
  static const Color errorDark = Color(0xffff9494);
}
