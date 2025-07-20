import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme({required bool isLight}) => ElevatedButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(AppDimens.elevatedButtonElevation),
          textStyle: WidgetStateProperty.all(
            const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.w600),
          ),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return isLight ? AppColors.getBtnDisabledForegroundLight() : AppColors.getBtnDisabledForegroundDark();
            }
            return Colors.white;
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return isLight ? AppColors.getBtnDisabledBackgroundLight() : AppColors.getBtnDisabledBackgroundDark();
            }
            return isLight ? AppColors.primaryLight : AppColors.primaryDark;
          }),
          fixedSize: WidgetStateProperty.all(const Size(double.maxFinite, AppDimens.elevatedButtonHeight)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return (isLight ? AppColors.primaryLight : AppColors.primaryDark).withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return (isLight ? AppColors.primaryLight : AppColors.primaryDark).withOpacity(0.05);
            }
            return null;
          }),
        ),
      );

  static TextButtonThemeData textButtonTheme({required bool isLight}) => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
          textStyle: WidgetStateProperty.all(
              const TextStyle(fontFamily: AppStrings.fontFamilyEn, fontWeight: FontWeight.w600)),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return (isLight ? AppColors.primaryLight : AppColors.primaryDark).withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return (isLight ? AppColors.primaryLight : AppColors.primaryDark).withOpacity(0.05);
            }
            return null;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
      );

  static IconButtonThemeData iconButtonTheme({required bool isLight}) => IconButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return (isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark).withOpacity(0.1);
            }
            if (states.contains(WidgetState.hovered)) {
              return (isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark).withOpacity(0.05);
            }
            return null;
          }),
        ),
      );
}
