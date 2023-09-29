import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimens {
  /// AppBar
  static double appBarHeight80 = 80;
  static double appBarHeight140 = 140;

  /// EdgeInsets
  static double edge8 = 8;
  static double edge10 = 10;
  static double edge15 = 15;
  static double edge20 = 20;

  /// SizedBoxes
  static double sizedBox10 = 10;
  static double sizedBox15 = 15;
  static double sizedBox20 = 20;
  static double sizedBox30 = 30;

  /// Flexes
  static int flex30 = 30;

  /// Texts
  static double displayLarge = 96.sp; // headline1
  static double displayMedium = 60.sp; // headline2
  static double displaySmall = 48.sp; // headline3
  static double headlineLarge = 48.sp;
  static double headlineMedium = 34.sp; // headline4
  static double headlineSmall = 24.sp; // headline5
  static double titleLarge = 16.sp; // headline6
  static double titleMedium = 12.sp; // subtitle1
  static double titleSmall = 12.sp; // subtitle2
  static double bodyLarge = 13.5.sp; // bodyText1
  static double bodyMedium = 13.5.sp; // bodyText2
  static double bodySmall = 10.sp; // caption
  static double labelLarge = 12.sp; // button
  static double labelMedium = 9.sp;
  static double labelSmall = 7.sp; // overline

  /// Font Sizes
  static double fontSize15 = 15;

  /// TextFields
  static double textFieldWidth(BuildContext context) => context.isTablet ? 270.w : double.infinity;

  /// Buttons
  static double elevatedButtonElevation = 3;
  static double elevatedButtonHeight = 60;

  /// Images
  static double imageHeight100 = 100;

  /// Border Radii
  static double borderRadius10 = 10;
  static double borderRadius15 = 15;
  static double borderRadius30 = 30;
}
