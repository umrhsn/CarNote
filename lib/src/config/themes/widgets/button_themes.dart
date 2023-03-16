import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class AppButtonThemes {
  static ElevatedButtonThemeData elevatedButtonTheme({required bool isLight}) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(3),
        textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor:
            MaterialStateProperty.all(isLight ? AppColors.primaryLight : AppColors.primaryDark),
        fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 60)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
