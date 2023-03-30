import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppScrollbarThemes {
  static ScrollbarThemeData scrollbarTheme({required bool isLight}) {
    return ScrollbarThemeData(
      thickness: MaterialStateProperty.all(5),
      thumbVisibility: MaterialStateProperty.all(true),
      trackVisibility: MaterialStateProperty.all(true),
      trackBorderColor: MaterialStateProperty.all(Colors.transparent),
      thumbColor: MaterialStateProperty.all(isLight ? AppColors.hintLight : AppColors.hintDark),
    );
  }
}
