import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconThemes {
  static IconThemeData iconTheme({required bool isLight}) {
    return IconThemeData(
      color: isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark,
      size: 24.0,
    );
  }

  static IconThemeData appBarIconTheme({required bool isLight}) {
    return IconThemeData(
      color: isLight ? AppColors.iconButtonLight : AppColors.iconButtonDark,
      size: 24.0,
    );
  }

  static IconThemeData primaryIconTheme({required bool isLight}) {
    return IconThemeData(
      color: isLight ? AppColors.primaryLight : AppColors.primaryDark,
      size: 24.0,
    );
  }
}
