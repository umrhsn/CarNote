import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialogThemes {
  static DialogThemeData dialogTheme({required bool isLight}) => DialogThemeData(
        iconColor: Colors.red,
        backgroundColor: isLight ? AppColors.cardLight : AppColors.cardDark,
      );
}
