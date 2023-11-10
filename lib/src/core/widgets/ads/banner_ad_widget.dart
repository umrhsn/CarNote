// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerAdWidget extends StatefulWidget {
//   const BannerAdWidget({super.key});
//
//   @override
//   State<BannerAdWidget> createState() => _BannerAdWidgetState();
// }
//
// class _BannerAdWidgetState extends State<BannerAdWidget> {
//   BannerAd? _bannerAd;
//
//   // ignore: unused_field
//   bool _isLoaded = false;
//
// // TODO: replace this test ad unit with your own ad unit.
//   final _adUnitId = Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716';
//
//   /// Loads a banner ad.
//   void _loadAd(BuildContext context) {
//     _bannerAd = BannerAd(
//       adUnitId: _adUnitId,
//       request: const AdRequest(),
//       size: AdSize.fullBanner,
//       listener: BannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           debugPrint('$ad loaded.');
//           setState(() => _isLoaded = true);
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('BannerAd failed to load: $err');
//           // Dispose the ad here to free resources.
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _loadAd(context));
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
