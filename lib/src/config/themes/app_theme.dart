import 'package:car_note/src/config/themes/widgets/app_bar_theme.dart';
import 'package:car_note/src/config/themes/widgets/button_themes.dart';
import 'package:car_note/src/config/themes/widgets/text_field_theme.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData appTheme({required bool isLight}) {
    return ThemeData(
      primaryColor: isLight ? AppColors.primaryLight : AppColors.primaryDark,
      primarySwatch: isLight ? AppColors.primarySwatchLight : AppColors.primarySwatchDark,
      scaffoldBackgroundColor:
          isLight ? AppColors.scaffoldBackgroundLight : AppColors.scaffoldBackgroundDark,
      brightness: isLight ? Brightness.light : Brightness.dark,
      appBarTheme: AppBarThemes.appBarTheme(isLight: isLight),
      elevatedButtonTheme: AppButtonThemes.elevatedButtonTheme(isLight: isLight),
      inputDecorationTheme: AppTextFieldThemes.inputDecorationTheme(isLight: isLight),
      fontFamily: AppStrings.fontFamily,
      useMaterial3: true,
    );
  }
}
