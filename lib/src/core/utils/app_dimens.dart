import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimens {
  /// AppBar
  static const double appBarHeight80 = 80;
  static const double appBarHeight140 = 140;

  /// Paddings
  static const double padding5 = 5;
  static const double padding8 = 8;
  static const double padding10 = 10;
  static const double padding15 = 15;
  static const double padding20 = 20;
  static const double padding70 = 70;

  /// SizedBoxes
  static const double sizedBox8 = 8;
  static const double sizedBox10 = 10;
  static const double sizedBox15 = 15;
  static const double sizedBox20 = 20;
  static const double sizedBox30 = 30;

  /// Flexes
  static int flex30 = 30;
  static int flex1000 = 1000;

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
  static const double fontSize15 = 15;

  /// Icon Sizes
  static const double iconSize50 = 50;

  /// TextFields
  static double textFieldWidth(BuildContext context) => context.isTablet ? 270.w : double.infinity;

  /// Buttons
  static const double elevatedButtonElevation = 3;
  static const double elevatedButtonHeight = 60;

  /// Images
  static const double imageHeight90 = 90;

  /// Border Radii
  static const double borderRadius10 = 10;
  static const double borderRadius15 = 15;
  static const double borderRadius30 = 30;
}
