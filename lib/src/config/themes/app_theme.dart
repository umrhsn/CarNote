import 'package:car_note/src/config/themes/widgets/app_bar_themes.dart';
import 'package:car_note/src/config/themes/widgets/button_themes.dart';
import 'package:car_note/src/config/themes/widgets/card_themes.dart';
import 'package:car_note/src/config/themes/widgets/dialog_themes.dart';
import 'package:car_note/src/config/themes/widgets/scrollbar_theme.dart';
import 'package:car_note/src/config/themes/widgets/text_field_theme.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData appTheme({required bool isLight}) {
    return ThemeData(
      fontFamily: AppStrings.fontFamilyEn,
      useMaterial3: true,
      primaryColor: isLight ? AppColors.primaryLight : AppColors.primaryDark,
      primarySwatch: AppColors.getPrimarySwatchColor(isLight: isLight),
      scaffoldBackgroundColor: isLight ? AppColors.scaffoldBackgroundLight : AppColors.scaffoldBackgroundDark,
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(isLight: isLight),
      inputDecorationTheme: AppTextFieldThemes.inputDecorationTheme(isLight: isLight),
      scrollbarTheme: AppScrollbarThemes.scrollbarTheme(isLight: isLight),
      cardTheme: AppCardThemes.cardTheme(isLight: isLight),
      dialogTheme: AppDialogThemes.dialogTheme(isLight: isLight),
      iconButtonTheme: AppButtonThemes.iconButtonTheme(isLight: isLight),
      textButtonTheme: AppButtonThemes.textButtonTheme(isLight: isLight),
    );
  }
}
