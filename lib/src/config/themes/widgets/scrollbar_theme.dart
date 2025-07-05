import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppScrollbarThemes {
  static ScrollbarThemeData scrollbarTheme({required bool isLight}) {
    return ScrollbarThemeData(
      thickness: WidgetStateProperty.all(5),
      thumbVisibility: WidgetStateProperty.all(true),
      trackVisibility: WidgetStateProperty.all(true),
      trackBorderColor: WidgetStateProperty.all(Colors.transparent),
      thumbColor: WidgetStateProperty.all(isLight ? AppColors.hintLight : AppColors.hintDark),
    );
  }
}
