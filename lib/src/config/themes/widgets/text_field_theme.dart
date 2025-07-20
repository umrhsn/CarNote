import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldThemes {
  static InputDecorationTheme inputDecorationTheme({required bool isLight}) {
    OutlineInputBorder focusedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark,
            strokeAlign: 0,
            width: 2.0));

    OutlineInputBorder outlineBorderWithColorHint = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: isLight ? AppColors.hintLight : AppColors.hintDark, width: 1.0, strokeAlign: 0));

    OutlineInputBorder focusedErrorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: isLight ? AppColors.errorLight : AppColors.errorDark, strokeAlign: 0, width: 2.0));

    OutlineInputBorder errorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            BorderSide(color: isLight ? AppColors.errorLight : AppColors.errorDark, strokeAlign: 0, width: 1.5));

    return InputDecorationTheme(
      filled: true,
      fillColor: isLight ? AppColors.cardLight : AppColors.cardDark,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      floatingLabelStyle: TextStyle(
        color: isLight ? AppColors.primaryLight : AppColors.primaryDark,
        fontWeight: FontWeight.w600,
      ),
      focusColor: isLight ? AppColors.textFieldFocusedLight : AppColors.textFieldFocusedDark,
      labelStyle: TextStyle(
        color: isLight ? AppColors.hintLight : AppColors.hintDark,
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: focusedBorder,
      enabledBorder: outlineBorderWithColorHint,
      disabledBorder: outlineBorderWithColorHint.copyWith(
        borderSide: BorderSide(
          color: isLight ? AppColors.hintLight.withOpacity(0.3) : AppColors.hintDark.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      focusedErrorBorder: focusedErrorBorder,
      errorBorder: errorBorder,
      errorStyle: TextStyle(
        color: isLight ? AppColors.errorLight : AppColors.errorDark,
        fontWeight: FontWeight.w500,
      ),
      border: outlineBorderWithColorHint,
      hintStyle: TextStyle(
          fontWeight: FontWeight.normal,
          color: isLight ? AppColors.hintLight.withOpacity(0.7) : AppColors.hintDark.withOpacity(0.7)),
    );
  }
}
