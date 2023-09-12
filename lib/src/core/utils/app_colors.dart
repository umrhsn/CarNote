import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

class AppColors {
  /// Scaffold
  static const Color scaffoldBackgroundLight = Color(0xffffffff);
  static const Color scaffoldBackgroundDark = Color(0xff000000); // 0xff0D1117

  /// Primary
  static const Color primaryLight = Color(0xff1F883D);
  static const Color primaryDark = Color(0xff238636);

  static MaterialColor primarySwatchLight = MaterialColor(
    primaryLight.value, //0%
    const <int, Color>{
      50: Color(0xff1f883d), //10%
      100: Color(0xff196d31), //20%
      200: Color(0xff165f2b), //30%
      300: Color(0xff135225), //40%
      400: Color(0xff10441f), //50%
      500: Color(0xff0c3618), //60%
      600: Color(0xff092912), //70%
      700: Color(0xff061b0c), //80%
      800: Color(0xff030e06), //90%
      900: Color(0xff000000), //100%
    },
  );

  static MaterialColor primarySwatchDark = MaterialColor(
    primaryDark.value, //0%
    const <int, Color>{
      50: Color(0xff359450), //10%
      100: Color(0xff4ca064), //20%
      200: Color(0xff62ac77), //30%
      300: Color(0xff79b88b), //40%
      400: Color(0xff8fc49e), //50%
      500: Color(0xffa5cfb1), //60%
      600: Color(0xffbcdbc5), //70%
      700: Color(0xffd2e7d8), //80%
      800: Color(0xffe9f3ec), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static Color getPrimaryColor(BuildContext context) =>
      context.isLight ? AppColors.primaryLight : AppColors.primaryDark;

  static Color getPrimarySwatchColor(BuildContext context) =>
      context.isLight ? AppColors.primarySwatchLight : AppColors.primarySwatchDark;

  /// Icons
  static const Color iconLight = Color(0xff54AEFF);
  static const Color iconDark = Color(0xff7D8590);

  /// TextFields

  static Color appBarTextFieldFillLight = Colors.white.withAlpha(40);
  static Color appBarTextFieldFillDark = Colors.white.withAlpha(30);
  static Color getAppBarTextFieldFill(BuildContext context) =>
      context.isLight ? AppColors.appBarTextFieldFillLight : AppColors.appBarTextFieldFillDark;

  static Color getAppBarTextFieldLabel(BuildContext context) =>
      context.isLight ? Colors.black.withAlpha(70) : Colors.white.withAlpha(80);

  static Color getAppBarTextFieldBorderAndLabelFocused(BuildContext context) =>
      context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  static Color getTextFieldBorderAndLabelFocused(BuildContext context) =>
      context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  static const Color disabledTextFieldLight = Color(0xffF6F8FA);
  static const Color disabledTextFieldDark = Color(0xff21262D);
  static Color textFieldFocusedLight = Colors.orange.shade900;
  static Color textFieldFocusedDark = Colors.white70;
  static Color getTextFieldBorderAndLabel(BuildContext context) =>
      context.isLight ? hintLight : hintDark;

  static Color getDisabledTextFieldFill(BuildContext context) =>
      context.isLight ? disabledTextFieldLight : disabledTextFieldDark;

  /// Buttons
  static Color textBtnLight = iconLight;
  static Color textBtnDark = iconDark;

  static Color btnDisabledLight = Colors.grey.withAlpha(100);
  static Color btnDisabledDark = Colors.white.withAlpha(70);

  static Color getBtnDisabledForeground(BuildContext context) =>
      context.isLight ? scaffoldBackgroundLight : scaffoldBackgroundLight.withAlpha(60);

  static Color getBtnDisabledBackground(BuildContext context) =>
      context.isLight ? btnDisabledLight : btnDisabledDark;

  static Color getTextBtnColor(BuildContext context) =>
      context.isLight ? textBtnLight : textBtnDark;

  /// Texts
  static Color textDisabledLight = Colors.grey.shade200;
  static Color textDisabledDark = Colors.grey.shade600;

  static const Color errorLight = Color(0xffd40000);
  static const Color errorDark = Color(0xffff9494);

  static const Color warningLight = Color(0xffd4ad00);
  static const Color warningDark = Color(0xfffff694);

  static const Color hintLight = Color(0xff656D76); // 0xff656D76
  static Color hintDark = const Color(0xff7C848F);

  static Color getWarningColor(BuildContext context) =>
      context.isLight ? warningLight : warningDark;

  static Color getErrorColor(BuildContext context) => Theme.of(context).colorScheme.error;

  static Color getNormalTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.onBackground;

  static Color getHintColor(BuildContext context) => context.isLight ? hintLight : hintDark;

  /// Cards
  static const Color cardLight = Color(0xffF6F8FA);
  static const Color cardDark = Color(0xff21262D);
}
