import 'dart:async';

import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/services/animations/animation_helper.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
import 'package:car_note/src/core/widgets/custom_progress_indictor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final splashDelay = 2;

  @override
  void initState() {
    super.initState();

    _loadWidget();
    _fadeInOutAnimation();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, checkFirstSeen);
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introSeen = (prefs.getBool('intro_seen') ?? false);

    if (introSeen) {
      Navigator.pushReplacementNamed(context, Routes.consumablesRoute);
    } else {
      await prefs.setBool('intro_seen', true);
      Navigator.pushReplacementNamed(context, Routes.carInfoRoute);
    }
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fadeInOutAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 1.0, end: 0.2).animate(_animationController);
    AnimationHelper.continuousReversibleAnimation(_animationController, _animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Positioned(
          top: context.height / 2.5,
          left: context.width / 2.85,
          child: FadeTransition(opacity: _animation, child: AssetManager.splashImage()),
        ),
        const Align(alignment: Alignment.bottomCenter, child: CustomProgressIndicator())
      ]),
    );
  }
}
