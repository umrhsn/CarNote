import 'package:car_note/src/core/services/ads/app_bar_banner_ad.dart';
import 'package:flutter/material.dart';

extension AppBarAdmobX on AppBar {
  PreferredSizeWidget withBottomAdmobBanner(BuildContext context) {
    return AppBarBannerAd(
      appBar: this,
      size: MediaQuery.of(context).size,
    );
  }
}
