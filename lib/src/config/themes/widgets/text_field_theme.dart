import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldThemes {
  static InputDecorationTheme inputDecorationTheme({required bool isLight}) {
    return InputDecorationTheme(
      border:
          OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
      hintStyle: TextStyle(color: isLight ? AppColors.hintColorLight : AppColors.hintColorDark),
      filled: true,
    );
  }
}
