import 'package:flutter/material.dart';

const String imgPath = 'assets/images';

class AssetManager {
  static const String icon = '$imgPath/icon.png';

  static Image splashImage() => Image.asset(icon, height: 150);
}
