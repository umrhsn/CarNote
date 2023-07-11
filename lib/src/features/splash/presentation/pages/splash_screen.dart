import 'dart:async';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/services/animations/animation_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/custom_progress_indictor.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final _splashDelay = 0;
  final SharedPreferences _prefs = di.sl<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    _loadWidget();
    _fadeInOutAnimation();
  }

  _loadWidget() async {
    var duration = Duration(seconds: _splashDelay);
    return Timer(duration, checkFirstSeen);
  }

  void checkFirstSeen() {
    if (CarCubit.carBox.get(AppStrings.carBox) != null) {
      _prefs.setBool(AppStrings.prefsBoolSeen, true);
    }
    navigate(_prefs.getBool(AppStrings.prefsBoolSeen) ?? false);
  }

  void navigate(bool seen) => seen
      ? Navigator.pushReplacementNamed(context, Routes.consumablesRoute)
      : Navigator.pushReplacementNamed(context, Routes.carInfoRoute);

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
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Expanded(
              child: Center(
                  child: FadeTransition(opacity: _animation, child: AssetManager.splashImage())),
            ),
            const CustomProgressIndicator()
          ]),
        ),
      ),
    );
  }
}
