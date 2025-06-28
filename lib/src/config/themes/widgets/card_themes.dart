import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppCardThemes {
  static CardThemeData cardTheme({required bool isLight}) => CardThemeData(color: isLight ? AppColors.cardLight : AppColors.cardDark);
}
