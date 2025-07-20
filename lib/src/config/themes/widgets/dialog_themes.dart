import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialogThemes {
  static DialogThemeData dialogTheme({required bool isLight}) => DialogThemeData(
        iconColor: isLight ? AppColors.errorLight : AppColors.errorDark,
        backgroundColor: isLight ? AppColors.cardLight : AppColors.cardDark,
        surfaceTintColor: Colors.transparent,
        shadowColor: isLight ? AppColors.boxShadowLight : AppColors.boxShadowDark,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        titleTextStyle: TextStyle(
          color: isLight ? Colors.black87 : Colors.white70,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: isLight ? Colors.black87 : Colors.white70,
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
      );
}
