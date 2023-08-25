import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color scaffoldBackgroundLight = Color(0xffffffff);
  static const Color scaffoldBackgroundDark = Color(0xff0D1117);

  static const Color primaryLight = Color(0xff1F883D);
  static const Color primaryDark = Color(0xff238636);

  static const Color iconLight = Color(0xff54AEFF);
  static const Color iconDark = Color(0xff7D8590);

  static const Color disabledTextFieldLight = Color(0xffF6F8FA);
  static const Color disabledTextFieldDark = Color(0xff21262D);

  static Color appBarTextFieldFillLight = Colors.white.withAlpha(40);
  static Color appBarTextFieldFillDark = Colors.white.withAlpha(30);

  static Color textFieldFocusedLight = Colors.orange.shade900;
  static Color textFieldFocusedDark = Colors.white70;

  // static Color appBarPrimaryLight = primarySwatchLight.shade400;
  // static Color appBarPrimaryDark = primarySwatchDark.shade300;

  // static Color floatingLabelDark = primarySwatchDark.shade200;

  static MaterialColor primarySwatchLight = MaterialColor(
    primaryLight.value, //0%
    const <int, Color>{
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

  static MaterialColor primarySwatchDark = MaterialColor(
    primaryDark.value, //0%
    const <int, Color>{
      50: Color(0xff47352a), //10%
      100: Color(0xff5c4b41), //20%
      200: Color(0xff706259), //30%
      300: Color(0xff857871), //40%
      400: Color(0xff998f89), //50%
      500: Color(0xffada5a0), //60%
      600: Color(0xffc2bcb8), //70%
      700: Color(0xffd6d2d0), //80%
      800: Color(0xffebe9e7), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static const Color hintLight = Color(0xff656D76); // 0xff656D76
  static Color hintDark = const Color(0xff7C848F);

  static Color textBtnLight = iconLight;
  static Color textBtnDark = iconDark;

  static Color btnDisabledLight = primaryDark.withAlpha(60);
  static Color btnDisabledDark = Colors.white.withAlpha(70);

  static Color textDisabledLight = Colors.grey.shade200;
  static Color textDisabledDark = Colors.grey.shade600;

  static const Color errorLight = Color(0xffd40000);
  static const Color errorDark = Color(0xffff9494);

  static const Color warningLight = Color(0xffd4ad00);
  static const Color warningDark = Color(0xfffff694);

  static const Color cardLight = Color(0xffF6F8FA);
  static const Color cardDark = Color(0xff21262D);

  static Color getPrimaryColor(BuildContext context) =>
      context.isLight ? AppColors.primaryLight : AppColors.primaryDark;

  static Color getPrimarySwatchColor(BuildContext context) =>
      context.isLight ? AppColors.primarySwatchLight : AppColors.primarySwatchDark;

  static Color getAppBarTextFieldFill(BuildContext context) =>
      context.isLight ? AppColors.appBarTextFieldFillLight : AppColors.appBarTextFieldFillDark;

  static Color getAppBarTextFieldLabel(BuildContext context) =>
      context.isLight ? Colors.black.withAlpha(70) : Colors.white.withAlpha(80);

  static Color getAppBarTextFieldBorderAndLabelFocused(BuildContext context) =>
      context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  // static Color getAppBarTextFieldBorderAndLabel(BuildContext context) =>
  //     context.isLight ? appBarPrimaryLight : appBarPrimaryDark;

  static Color getTextFieldBorderAndLabelFocused(BuildContext context) =>
      context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  static Color getTextFieldBorderAndLabel(BuildContext context) =>
      context.isLight ? hintLight : hintDark;

  static Color getDisabledTextFieldFill(BuildContext context) =>
      context.isLight ? disabledTextFieldLight : disabledTextFieldDark;

  static Color getWarningColor(BuildContext context) =>
      context.isLight ? warningLight : warningDark;

  static Color getErrorColor(BuildContext context) => Theme.of(context).colorScheme.error;

  static Color getNormalTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.onBackground;

  static Color getHintColor(BuildContext context) => context.isLight ? hintLight : hintDark;

  static Color getBtnDisabledForeground(BuildContext context) =>
      context.isLight ? scaffoldBackgroundLight : scaffoldBackgroundLight.withAlpha(60);

  static Color getBtnDisabledBackground(BuildContext context) =>
      context.isLight ? btnDisabledLight : btnDisabledDark;

  static Color getTextBtnColor(BuildContext context) =>
      context.isLight ? textBtnLight : textBtnDark;
}
