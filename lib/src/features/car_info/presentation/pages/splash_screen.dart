import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/features/car_info/presentation/pages/car_info.dart';
import 'package:car_note/src/features/car_info/presentation/pages/consumables_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
