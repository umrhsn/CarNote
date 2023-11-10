import 'dart:async';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/animations/animation_helper.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/indicators/custom_progress_indictor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final SharedPreferences _prefs = di.sl<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    _loadWidget();
    _fadeInOutAnimation();
  }

  _loadWidget() async {
    var duration = const Duration(seconds: AppNums.durationSplashDelay);
    return Timer(duration, _checkFirstSeen);
  }

  void _checkFirstSeen() {
    if (DatabaseHelper.carBox.get(AppKeys.carBox) != null) {
      _prefs.setBool(AppKeys.prefsBoolSeen, true);
    }
    _navigate(_prefs.getBool(AppKeys.prefsBoolSeen) ?? false);
  }

  void _navigate(bool seen) =>
      seen ? Navigator.pushReplacementNamed(context, Routes.consumablesRoute) : Navigator.pushReplacementNamed(context, Routes.chooseLanguageRoute);

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fadeInOutAnimation() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: AppNums.animationSplashBegin, end: AppNums.animationSplashEnd).animate(_animationController);
    AnimationHelper.continuousReversibleAnimation(_animationController, _animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Expanded(
              child: Center(child: FadeTransition(opacity: _animation, child: AssetManager.splashImage())),
            ),
            const CustomProgressIndicator()
          ]),
        ),
      ),
    );
  }
}
