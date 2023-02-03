import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppScrollbarThemes {
  static ScrollbarThemeData scrollbarTheme({required bool isLight}) {
    return ScrollbarThemeData(
      interactive: true,
      radius: const Radius.circular(10),
      thickness: MaterialStateProperty.all(5),
      thumbVisibility: MaterialStateProperty.all(true),
      trackVisibility: MaterialStateProperty.all(true),
      trackBorderColor: MaterialStateProperty.all(Colors.transparent),
      thumbColor: MaterialStateProperty.all(
          isLight ? AppColors.hintColorLight.withAlpha(80) : AppColors.hintColorDark),
    );
  }
}
