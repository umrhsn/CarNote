import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialogThemes {
  static DialogTheme dialogTheme({required bool isLight}) => DialogTheme(
        iconColor: Colors.red,
        backgroundColor: isLight ? AppColors.cardLight : AppColors.cardDark,
      );
}
