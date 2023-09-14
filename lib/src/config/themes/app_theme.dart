import 'package:car_note/src/config/themes/widgets/app_bar_theme.dart';
import 'package:car_note/src/config/themes/widgets/button_themes.dart';
import 'package:car_note/src/config/themes/widgets/scrollbar_theme.dart';
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
      scrollbarTheme: AppScrollbarThemes.scrollbarTheme(isLight: isLight),
      fontFamily: AppStrings.fontFamilyEn,
      useMaterial3: true,
      cardTheme: CardTheme(color: isLight ? AppColors.cardLight : AppColors.cardDark),
      dialogBackgroundColor: isLight ? AppColors.cardLight : AppColors.cardDark,
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(isLight ? AppColors.iconLight : AppColors.iconDark))),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
