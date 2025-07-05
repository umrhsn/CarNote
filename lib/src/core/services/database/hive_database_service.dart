import 'dart:io';
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/features/car_info/data/models/car_model.dart';
import 'package:car_note/src/features/consumables/data/models/consumable_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HiveDatabaseService implements DatabaseService {
  final SharedPreferences sharedPreferences;

  HiveDatabaseService({required this.sharedPreferences});

  Box<CarModel>? _carBox;
  Box<List>? _consumableBox;

  Box<CarModel> get carBox => _carBox!;

  Box<List> get consumableBox => _consumableBox!;

  @override
  Future<void> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter<CarModel>(CarModelAdapter())
      ..registerAdapter<ConsumableModel>(ConsumableModelAdapter());

    _carBox = await Hive.openBox<CarModel>(AppKeys.carBox);
    _consumableBox = await Hive.openBox<List>(AppKeys.consumableBox);

    await _initializeDefaultConsumables();
  }

  Future<void> _initializeDefaultConsumables() async {
    if (sharedPreferences.getBool(AppKeys.prefsBoolListAdded) == null) {
      _consumableBox!.put(AppKeys.consumableBox, []);

      for (int index = 0;
          index < AppLists.consumablesEnglishList.length;
          index++) {
        _consumableBox!.get(AppKeys.consumableBox)!.add(
              ConsumableModel(
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
  Future<bool> saveCarModel(CarModel carModel) async {
    try {
      await _carBox!.put(AppKeys.carBox, carModel);
      return _carBox!.get(AppKeys.carBox) != null;
    } catch (e) {
      return false;
    }
  }

  @override
  CarModel? getCarModel() {
    return _carBox!.get(AppKeys.carBox);
  }

  @override
  Future<void> saveConsumableModels(
      List<ConsumableModel> consumableModels) async {
    await _consumableBox!.put(AppKeys.consumableBox, consumableModels);
  }

  @override
  List<ConsumableModel> getConsumableModels() {
    final list = _consumableBox!.get(AppKeys.consumableBox);
    if (list == null) return [];
    return List<ConsumableModel>.from(list);
  }

  @override
  Future<bool> addConsumableModel(ConsumableModel consumableModel) async {
    try {
      final list = getConsumableModels();
      final newConsumableModel = ConsumableModel(
        id: list.length,
        name: consumableModel.name,
        lastChangedAt: consumableModel.lastChangedAt,
        changeInterval: consumableModel.changeInterval,
        remainingKm: consumableModel.remainingKm,
      );

      list.add(newConsumableModel);
      await saveConsumableModels(list);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void removeConsumableModel(int index) {
    final list = getConsumableModels();
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
      saveConsumableModels(list);
    }
  }

  @override
  void resetConsumableModel(int index) {
    final list = getConsumableModels();
    if (index >= 0 && index < list.length) {
      list[index] = ConsumableModel(
        id: list[index].id,
        name: list[index].name,
        lastChangedAt: 0,
        changeInterval: 0,
        remainingKm: 0,
      );
      saveConsumableModels(list);
    }
  }

  @override
  void resetAllConsumableModels() {
    final list = getConsumableModels();
    for (int i = 0; i < list.length; i++) {
      list[i] = ConsumableModel(
        id: list[i].id,
        name: list[i].name,
        lastChangedAt: 0,
        changeInterval: 0,
        remainingKm: 0,
      );
    }
    saveConsumableModels(list);
  }

  @override
  void removeAllConsumableModels() {
    _consumableBox!.put(AppKeys.consumableBox, []);
  }

  @override
  void reorderConsumableModels(int oldIndex, int newIndex) {
    final list = getConsumableModels();
    if (oldIndex < newIndex) newIndex -= 1;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
    saveConsumableModels(list);
  }

  @override
  bool updateConsumableModelName(int index, String name) {
    if (name.isEmpty) return false;

    final list = getConsumableModels();
    if (index >= 0 && index < list.length) {
      list[index] = ConsumableModel(
        id: list[index].id,
        name: name,
        lastChangedAt: list[index].lastChangedAt,
        changeInterval: list[index].changeInterval,
        remainingKm: list[index].remainingKm,
      );
      saveConsumableModels(list);
      return true;
    }
    return false;
  }
}
