import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldThemes {
  static InputDecorationTheme inputDecorationTheme({required bool isLight}) {
    OutlineInputBorder outlineBorderWithColorHint = OutlineInputBorder(
      borderSide: BorderSide(
        color: isLight ? AppColors.hintLight : AppColors.hintDark,
        width: 1.2,
        strokeAlign: 0,
      ),
    );

    OutlineInputBorder outlineBorderWithColorPrimary = OutlineInputBorder(
      borderSide: BorderSide(
        color: isLight ? AppColors.primaryLight : AppColors.floatingLabelDark,
        width: 1.2,
        strokeAlign: 0,
      ),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: isLight
          ? AppColors.btnDisabledLight.withAlpha(20)
          : AppColors.btnDisabledDark.withAlpha(30),
      floatingLabelStyle: TextStyle(
        color: isLight ? AppColors.primaryLight : AppColors.floatingLabelDark,
        fontWeight: FontWeight.bold,
      ),
      focusColor: isLight ? AppColors.primaryLight : AppColors.floatingLabelDark,
      labelStyle: TextStyle(color: isLight ? AppColors.hintLight : AppColors.hintDark),
      focusedBorder: outlineBorderWithColorPrimary,
      enabledBorder: outlineBorderWithColorHint,
      disabledBorder: outlineBorderWithColorHint,
      border: outlineBorderWithColorHint,
      hintStyle: TextStyle(
        fontWeight: FontWeight.normal,
        color: isLight ? AppColors.hintLight : AppColors.hintDark,
      ),
    );
  }
}
