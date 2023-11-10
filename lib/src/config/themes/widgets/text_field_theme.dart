import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldThemes {
  static InputDecorationTheme inputDecorationTheme({required bool isLight}) {
    OutlineInputBorder focusedBorder = OutlineInputBorder(
        borderSide: BorderSide(color: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark, strokeAlign: 0, width: 1.2));

    OutlineInputBorder outlineBorderWithColorHint =
        OutlineInputBorder(borderSide: BorderSide(color: isLight ? AppColors.hintLight : AppColors.hintDark, width: 1.2, strokeAlign: 0));

    OutlineInputBorder focusedErrorBorder =
        OutlineInputBorder(borderSide: BorderSide(color: isLight ? AppColors.errorLight : AppColors.errorDark, strokeAlign: 0, width: 2));
    OutlineInputBorder errorBorder =
        OutlineInputBorder(borderSide: BorderSide(color: isLight ? AppColors.errorLight : AppColors.errorDark, strokeAlign: 0, width: 1.2));

    return InputDecorationTheme(
      filled: true,
      floatingLabelStyle: TextStyle(
        color: isLight ? AppColors.hintLight : AppColors.hintDark,
        fontWeight: FontWeight.bold,
      ),
      focusColor: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark,
      labelStyle: TextStyle(color: isLight ? AppColors.hintLight : AppColors.hintDark),
      focusedBorder: focusedBorder,
      enabledBorder: outlineBorderWithColorHint,
      disabledBorder: outlineBorderWithColorHint,
      focusedErrorBorder: focusedErrorBorder,
      errorBorder: errorBorder,
      errorStyle: TextStyle(color: isLight ? AppColors.errorLight : AppColors.errorDark),
      border: outlineBorderWithColorHint,
      hintStyle: TextStyle(fontWeight: FontWeight.normal, color: isLight ? AppColors.hintLight : AppColors.hintDark),
    );
  }
}
