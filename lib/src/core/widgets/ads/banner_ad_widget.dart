// import 'dart:io';
// import 'package:car_note/src/core/utils/app_ids.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerAdWidget extends StatefulWidget {
//   // TODO: replace this test ad unit with your own ad unit.
//   /// App ID: ca-app-pub-8427642569951372~3190331585
//
//   /// Android sample unit ID: ca-app-pub-3940256099942544/6300978111
//
//   /// iOS sample unit ID: ca-app-pub-3940256099942544/2934735716
//
//   final String androidAdUnitId;
//   final String? iosAdUnitId;
//
//   const BannerAdWidget({super.key, required this.androidAdUnitId, this.iosAdUnitId});
//
//   @override
//   State<BannerAdWidget> createState() => _BannerAdWidgetState();
// }
//
// class _BannerAdWidgetState extends State<BannerAdWidget> {
//   BannerAd? _bannerAd;
//
//   /// Loads a banner ad.
//   void _loadAd() {
//     debugPrint('androidAdUnitId = ${widget.androidAdUnitId}');
//     BannerAd(
//       adUnitId: Platform.isAndroid ? widget.androidAdUnitId : widget.iosAdUnitId!,
//       request: const AdRequest(),
//       size: AdSize.banner,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) => setState(() => _bannerAd = ad as BannerAd),
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) => ad.dispose(),
//         // Called when an ad opens an overlay that covers the screen.
//         onAdOpened: (Ad ad) {},
//         // Called when an ad removes an overlay that covers the screen.
//         onAdClosed: (Ad ad) {},
//         // Called when an impression occurs on the ad.
//         onAdImpression: (Ad ad) {},
//       ),
//     ).load();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadAd();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_bannerAd != null) {
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: SafeArea(
//           child: SizedBox(
//             width: _bannerAd!.size.width.toDouble(),
//             height: _bannerAd!.size.height.toDouble(),
//             child: AdWidget(ad: _bannerAd!),
//           ),
//         ),
//       );
//     }
//     return const SizedBox();
//   }
// }
