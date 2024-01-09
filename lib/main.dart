import 'package:car_note/car_note.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/notifications/notifications_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_note/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();
  await DatabaseHelper().init();
  NotificationsHelper().init();
  // MobileAds.instance.initialize();

  runApp(const CarNote());
}
