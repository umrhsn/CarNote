// lib/main.dart
import 'package:car_note/car_note.dart';
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/core/services/notification/notifications_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_note/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize dependency injection
  await di.init();

  // Initialize services
  await di.sl<DatabaseService>().init();
  await NotificationsHelper.init();

  // MobileAds.instance.initialize();

  runApp(const CarNote());
}
