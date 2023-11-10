import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme({required bool isLight}) => ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(AppDimens.elevatedButtonElevation),
          textStyle: MaterialStateProperty.all(
            const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.bold),
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, AppDimens.elevatedButtonHeight)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.borderRadius10)),
          ),
        ),
      );

  static TextButtonThemeData textButtonTheme({required bool isLight}) => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          textStyle: MaterialStateProperty.all(const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.bold)),
        ),
      );

  static IconButtonThemeData iconButtonTheme({required bool isLight}) =>
      IconButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(isLight ? AppColors.iconLight : AppColors.iconDark)));
}
