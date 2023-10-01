import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppCardThemes {
  static CardTheme cardTheme({required bool isLight}) => CardTheme(color: isLight ? AppColors.cardLight : AppColors.cardDark);
}
