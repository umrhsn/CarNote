// lib/src/core/services/database/hive_database_service.dart
import 'dart:io';
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDatabaseService implements DatabaseService {
  final SharedPreferences sharedPreferences;

  HiveDatabaseService({required this.sharedPreferences});

  Box<Car>? _carBox;
  Box<List>? _consumableBox;

  Box<Car> get carBox => _carBox!;

  Box<List> get consumableBox => _consumableBox!;

  @override
  Future<void> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter<Car>(CarAdapter())
      ..registerAdapter<Consumable>(ConsumableAdapter());

    _carBox = await Hive.openBox<Car>(AppKeys.carBox);
    _consumableBox = await Hive.openBox<List>(AppKeys.consumableBox);

    if (sharedPreferences.getBool(AppKeys.prefsBoolListAdded) == null) {
      _consumableBox!.put(AppKeys.consumableBox, []);

      for (int index = 0;
          index < AppLists.consumablesEnglishList.length;
          index++) {
        _consumableBox!.get(AppKeys.consumableBox)!.add(
              Consumable(
                id: index,
                name:
                    "${AppLists.consumablesEnglishList[index]}  ${AppLists.consumablesArabicList[index]}",
                lastChangedAt: 0,
                changeInterval: 0,
                remainingKm: 0,
              ),
            );
      }

      if (_consumableBox!.get(AppKeys.consumableBox) != null) {
        sharedPreferences.setBool(AppKeys.prefsBoolListAdded, true);
      }
    }
  }

  @override
  Future<bool> saveCar(Car car) async {
    try {
      await _carBox!.put(AppKeys.carBox, car);
      return _carBox!.get(AppKeys.carBox) != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Car? getCar() {
    return _carBox!.get(AppKeys.carBox);
  }

  @override
  Future<void> saveConsumables(List<Consumable> consumables) async {
    await _consumableBox!.put(AppKeys.consumableBox, consumables);
  }

  @override
  List<Consumable> getConsumables() {
    final list = _consumableBox!.get(AppKeys.consumableBox);
    if (list == null) return [];
    return List<Consumable>.from(list);
  }

  @override
  Future<bool> addConsumable(Consumable consumable) async {
    try {
      final list = getConsumables();
      final newConsumable = Consumable(
        id: list.length,
        name: consumable.name,
        lastChangedAt: consumable.lastChangedAt,
        changeInterval: consumable.changeInterval,
        remainingKm: consumable.remainingKm,
      );

      list.add(newConsumable);
      await saveConsumables(list);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void removeConsumable(int index) {
    final list = getConsumables();
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      saveConsumables(list);
    }
  }

  @override
  void resetConsumable(int index) {
    final list = getConsumables();
    if (index >= 0 && index < list.length) {
      list[index] = Consumable(
        id: list[index].id,
        name: list[index].name,
        lastChangedAt: 0,
        changeInterval: 0,
        remainingKm: 0,
      );
      saveConsumables(list);
    }
  }

  @override
  void resetAllConsumables() {
    final list = getConsumables();
    for (int i = 0; i < list.length; i++) {
      list[i] = Consumable(
        id: list[i].id,
        name: list[i].name,
        lastChangedAt: 0,
        changeInterval: 0,
        remainingKm: 0,
      );
    }
    saveConsumables(list);
  }

  @override
  void removeAllConsumables() {
    _consumableBox!.put(AppKeys.consumableBox, []);
  }

  @override
  void reorderConsumables(int oldIndex, int newIndex) {
    final list = getConsumables();
    if (oldIndex < newIndex) newIndex -= 1;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    saveConsumables(list);
  }

  @override
  bool updateConsumableName(int index, String name) {
    if (name.isEmpty) return false;

    final list = getConsumables();
    if (index >= 0 && index < list.length) {
      list[index] = Consumable(
        id: list[index].id,
        name: name,
        lastChangedAt: list[index].lastChangedAt,
        changeInterval: list[index].changeInterval,
        remainingKm: list[index].remainingKm,
      );
      saveConsumables(list);
      return true;
    }
    return false;
  }
}
