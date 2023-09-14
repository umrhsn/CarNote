import 'dart:math';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:car_note/src/core/services/ads/ad_services.dart';
import 'package:flutter/material.dart';

class AppBarBannerAd extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final Size size;

  const AppBarBannerAd({
    Key? key,
    required this.appBar,
    required this.size,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height + height);

  double get height => max(size.height * .06, 50.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        appBar,
        SizedBox(
          width: size.width,
          height: height,
          child: AdmobBanner(
            adUnitId: AdServices.getBannerAdUnitId(),
            adSize: AdmobBannerSize.ADAPTIVE_BANNER(
              width: size.width.toInt(),
            ),
          ),
        )
      ],
    );
  }
}
