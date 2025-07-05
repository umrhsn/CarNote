import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme({required bool isLight}) => ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(AppDimens.elevatedButtonElevation),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.bold),
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          fixedSize: WidgetStateProperty.all(const Size(double.maxFinite, AppDimens.elevatedButtonHeight)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.borderRadius10)),
          ),
        ),
      );

  static TextButtonThemeData textButtonTheme({required bool isLight}) => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          textStyle: WidgetStateProperty.all(const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.bold)),
        ),
      );

  static IconButtonThemeData iconButtonTheme({required bool isLight}) =>
      IconButtonThemeData(style: ButtonStyle(foregroundColor: WidgetStateProperty.all(isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark)));
}
