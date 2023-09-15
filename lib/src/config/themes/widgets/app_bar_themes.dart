import 'package:car_note/src/config/themes/system/system_overlay_style.dart';
import 'package:flutter/material.dart';

class AppBarThemes {
  static AppBarTheme appBarTheme({required bool isLight}) {
    return AppBarTheme(
      systemOverlayStyle: AppSystemUiOverlayStyle.setSystemUiOverlayStyle(isLight: isLight),
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      toolbarHeight: 0,
      elevation: 0,
    );
  }
}
