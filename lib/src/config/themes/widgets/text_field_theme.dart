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

    return InputDecorationTheme(
      filled: true,
      floatingLabelStyle: TextStyle(
        color: isLight ? AppColors.hintLight : AppColors.hintDark,
        fontWeight: FontWeight.bold,
      ),
      focusColor: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark,
      labelStyle: TextStyle(color: isLight ? AppColors.hintLight : AppColors.hintDark),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark, strokeAlign: 0, width: 1.2),
      ),
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
