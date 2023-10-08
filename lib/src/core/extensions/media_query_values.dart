import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get paddingTop => MediaQuery.of(this).padding.top;
  double get paddingBottom => MediaQuery.of(this).padding.bottom;


  Brightness get platformBrightness => MediaQuery.of(this).platformBrightness;
  bool get isLight => platformBrightness == Brightness.light;

  Orientation get orientation => MediaQuery.of(this).orientation;
  bool get isPortrait => orientation == Orientation.portrait;
  bool get isTablet => size.shortestSide >= 600;
}
