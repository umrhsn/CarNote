import 'dart:io';

import 'package:car_note/app.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter<Car>(CarAdapter())
    ..registerAdapter<Consumable>(ConsumableAdapter());

  await Hive.openBox<Car>(AppStrings.carBox);
  await Hive.openBox<Consumable>(AppStrings.consumableBox);

  runApp(const CarNote());
}
