import 'dart:io';

import 'package:car_note/app.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:car_note/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Dependency Injection init
  await di.init();

  /// Database init
  Directory dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter<Car>(CarAdapter())
    ..registerAdapter<Consumable>(ConsumableAdapter());

  await Hive.openBox<Car>(AppStrings.carBox);
  await Hive.openBox<Consumable>(AppStrings.consumableBox);

  /// Notifications init
  AwesomeNotifications().initialize(
    'resource://drawable/icon',
    [
      NotificationChannel(
        channelKey: AppStrings.notifChannelBasicKey,
        channelName: AppStrings.notifChannelBasicName,
        channelDescription: AppStrings.notifChannelBasicDescription,
        ledColor: AppColors.primaryLight,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        channelKey: AppStrings.notifChannelScheduledKey,
        channelName: AppStrings.notifChannelScheduledName,
        channelDescription: AppStrings.notifChannelScheduledDescription,
        ledColor: AppColors.primaryLight,
        importance: NotificationImportance.High,
      ),
    ],
    // Channel groups are only visual and are not required
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: AppStrings.notifChannelBasicGroupKey,
        channelGroupName: AppStrings.notifChannelBasicGroupName,
      ),
      NotificationChannelGroup(
        channelGroupKey: AppStrings.notifChannelScheduledGroupKey,
        channelGroupName: AppStrings.notifChannelScheduledGroupName,
      ),
    ],
  );

  Admob.initialize();

  runApp(const CarNote());
}
