// lib/src/core/database/database_helper.dart
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/data/models/car_model.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/data/models/consumable_model.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class DatabaseHelper {
  init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      // Use data models for Hive adapters, not domain entities
      ..registerAdapter<CarModel>(CarModelAdapter())
      ..registerAdapter<ConsumableModel>(ConsumableModelAdapter());

    await Hive.openBox<CarModel>(AppKeys.carBox);
    await Hive.openBox<List>(AppKeys.consumableBox);

    if (di.sl<SharedPreferences>().getBool(AppKeys.prefsBoolListAdded) ==
        null) {
      _consumableBox.put(AppKeys.consumableBox, []);

      for (int index = 0; index < AppLists.consumables.length; index++) {
        _consumableBox.get(AppKeys.consumableBox)!.add(
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

      if (_consumableBox.get(AppKeys.consumableBox) != null) {
        di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolListAdded, true);
      }
    }
  }

  /// Car - Updated to use CarModel
  static final Box<CarModel> _carBox = Hive.box<CarModel>(AppKeys.carBox);

  static Box<CarModel> get carBox => _carBox;

  static Future<bool> writeCarData(BuildContext context) async {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    CarCubit carCubit = CarCubit.get(context);
    bool isNotNull = true;

    // Create domain entity first
    final car = Car(
      type: carCubit.carTypeController.text.trim(),
      modelYear: int.parse(carCubit.modelYearController.text.trim()),
      currentKm: int.parse(
          carCubit.currentKmController.text.trim().removeThousandSeparator()),
    );

    // Convert to data model for persistence
    final carModel = CarModel.fromEntity(car);

    _carBox.put(AppKeys.carBox, carModel);

    if (_carBox.get(AppKeys.carBox) == null) isNotNull = false;

    if (isNotNull) {
      prefs.setBool(AppKeys.prefsBoolSeen, true);
      BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }

    return prefs.getBool(AppKeys.prefsBoolSeen) ?? false;
  }

  /// Helper method to get Car domain entity
  static Car? getCarEntity() {
    final carModel = _carBox.get(AppKeys.carBox);
    return carModel?.toEntity();
  }

  /// Consumables - Updated to use ConsumableModel
  static final Box<List> _consumableBox = Hive.box<List>(AppKeys.consumableBox);

  static Box<List> get consumableBox => _consumableBox;

  /// Helper method to get Consumable domain entities
  static List<Consumable> getConsumableEntities() {
    final list = _consumableBox.get(AppKeys.consumableBox);
    if (list == null) return [];

    return list
        .map<Consumable>((item) => item is ConsumableModel
                ? item.toEntity()
                : item as Consumable // For backward compatibility
            )
        .toList();
  }

  /// Helper method to get count of consumables
  static int getConsumableCount() {
    return _consumableBox.get(AppKeys.consumableBox)?.length ?? 0;
  }

  static Future<bool> writeConsumableName(
      BuildContext context, int index) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    if (consumableCubit.consumableNameController.text.isEmpty) {
      return false;
    } else {
      final list = _consumableBox.get(AppKeys.consumableBox)!;
      if (list[index] is ConsumableModel) {
        (list[index] as ConsumableModel).name =
            consumableCubit.consumableNameController.text;
      } else {
        // Convert to model if it's still old format
        final oldItem = list[index] as Consumable;
        list[index] = ConsumableModel(
          id: oldItem.id,
          name: consumableCubit.consumableNameController.text,
          lastChangedAt: oldItem.lastChangedAt,
          changeInterval: oldItem.changeInterval,
          remainingKm: oldItem.remainingKm,
        );
      }

      writeConsumablesData(context).then((value) =>
          BotToast.showText(text: AppStrings.dataSavedSuccessfully(context)));
      return true;
    }
  }

  static Future<void> writeConsumablesData(BuildContext context) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    // Update car data
    final currentCarModel = _carBox.get(AppKeys.carBox);
    if (currentCarModel != null) {
      final updatedCar = Car(
        type: currentCarModel.type,
        modelYear: currentCarModel.modelYear,
        currentKm: int.parse(consumableCubit.currentKmController.text
            .trim()
            .removeThousandSeparator()),
      );

      _carBox.put(AppKeys.carBox, CarModel.fromEntity(updatedCar));
    }

    List<ConsumableModel> list = [];

    for (int index = 0; index < getConsumableCount(); index++) {
      final currentList = _consumableBox.get(AppKeys.consumableBox)!;
      final existingItem = currentList[index];

      String itemName;
      if (existingItem is ConsumableModel) {
        itemName = existingItem.name;
      } else {
        itemName = (existingItem as Consumable).name;
      }

      final consumableModel = ConsumableModel(
        id: index,
        name: itemName,
        lastChangedAt:
            consumableCubit.lastChangedAtControllers[index].text.isNotEmpty
                ? int.parse(consumableCubit.lastChangedAtControllers[index].text
                    .removeThousandSeparator())
                : 0,
        changeInterval: consumableCubit
                .changeIntervalControllers[index].text.isNotEmpty
            ? int.parse(consumableCubit.changeIntervalControllers[index].text
                .removeThousandSeparator())
            : 0,
        remainingKm:
            consumableCubit.remainingKmControllers[index].text.isNotEmpty
                ? int.parse(consumableCubit.remainingKmControllers[index].text
                    .removeThousandSeparator())
                : 0,
      );

      list.add(consumableModel);
    }

    _consumableBox.put(AppKeys.consumableBox, list);
  }

  static Future<bool> addConsumable(
    BuildContext context, {
    required String name,
    required int lastChangedAt,
    required int changeInterval,
  }) async {
    if (name.isEmpty || lastChangedAt == 0 || changeInterval == 0) return false;

    final consumableModel = ConsumableModel(
      id: _consumableBox.get(AppKeys.consumableBox)!.length,
      name: name.trim(),
      lastChangedAt: lastChangedAt,
      changeInterval: changeInterval,
      remainingKm: 0,
    );

    _consumableBox.get(AppKeys.consumableBox)!.add(consumableModel);
    _consumableBox.put(
        AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers
        .add(TextEditingController(text: lastChangedAt.toThousands()));
    consumableCubit.changeIntervalControllers
        .add(TextEditingController(text: changeInterval.toThousands()));
    consumableCubit.remainingKmControllers.add(TextEditingController());

    consumableCubit.lastChangedAtFocuses.add(FocusNode());
    consumableCubit.changeIntervalFocuses.add(FocusNode());
    consumableCubit.remainingKmFocuses.add(FocusNode());

    return true;
  }

  static void resetConsumable(int index, BuildContext context) {
    List<ConsumableModel> list = [];

    final currentList = _consumableBox.get(AppKeys.consumableBox)!;
    for (int i = 0; i < currentList.length; i++) {
      final item = currentList[i];

      if (item is ConsumableModel) {
        list.add(item);
      } else {
        // Convert old format to new
        final oldItem = item as Consumable;
        list.add(ConsumableModel.fromEntity(oldItem));
      }
    }

    list[index] = ConsumableModel(
        id: list[index].id,
        name: list[index].name,
        lastChangedAt: 0,
        changeInterval: 0,
        remainingKm: 0);

    _consumableBox.put(AppKeys.consumableBox, list);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers[index].text = '';
    consumableCubit.changeIntervalControllers[index].text = '';
    consumableCubit.remainingKmControllers[index].text = '';

    BotToast.showText(text: AppStrings.resetItemSuccessfully(context));
  }

  static void removeConsumable(int index, BuildContext context) {
    _consumableBox.get(AppKeys.consumableBox)!.removeAt(index);
    _consumableBox.put(
        AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers.removeAt(index);
    consumableCubit.changeIntervalControllers.removeAt(index);
    consumableCubit.remainingKmControllers.removeAt(index);

    consumableCubit.lastChangedAtFocuses.removeAt(index);
    consumableCubit.changeIntervalFocuses.removeAt(index);
    consumableCubit.remainingKmFocuses.removeAt(index);

    BotToast.showText(text: AppStrings.removedItemSuccessfully(context));
  }

  static void resetAllCards(BuildContext context) {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);
    List<ConsumableModel> list = [];

    final currentList = _consumableBox.get(AppKeys.consumableBox)!;
    for (int index = 0; index < currentList.length; index++) {
      final item = currentList[index];

      String itemName;
      int itemId;
      if (item is ConsumableModel) {
        itemName = item.name;
        itemId = item.id;
      } else {
        final oldItem = item as Consumable;
        itemName = oldItem.name;
        itemId = oldItem.id;
      }

      list.add(ConsumableModel(
          id: itemId,
          name: itemName,
          lastChangedAt: 0,
          changeInterval: 0,
          remainingKm: 0));
      consumableCubit.lastChangedAtControllers[index].text = '';
      consumableCubit.changeIntervalControllers[index].text = '';
      consumableCubit.remainingKmControllers[index].text = '';
    }

    _consumableBox.put(AppKeys.consumableBox, list);

    BotToast.showText(text: AppStrings.resetAllCards(context));
  }

  static void removeAllCards(BuildContext context) {
    _consumableBox.get(AppKeys.consumableBox)!.clear();
    _consumableBox.put(
        AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers.clear();
    consumableCubit.changeIntervalControllers.clear();
    consumableCubit.remainingKmControllers.clear();

    consumableCubit.lastChangedAtFocuses.clear();
    consumableCubit.changeIntervalFocuses.clear();
    consumableCubit.remainingKmFocuses.clear();

    BotToast.showText(text: AppStrings.removedAllCards(context));
  }

  static void changeConsumableOrder(
      BuildContext context, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    final currentList = _consumableBox.get(AppKeys.consumableBox)!;
    final item = currentList.removeAt(oldIndex);

    // Ensure item is a ConsumableModel
    ConsumableModel itemModel;
    if (item is ConsumableModel) {
      itemModel = item;
    } else {
      itemModel = ConsumableModel.fromEntity(item as Consumable);
    }

    int lastChangedAt = int.parse(consumableCubit.lastChangedAtControllers
        .removeAt(oldIndex)
        .text
        .removeThousandSeparator());
    int changeInterval = int.parse(consumableCubit.changeIntervalControllers
        .removeAt(oldIndex)
        .text
        .removeThousandSeparator());
    int remainingKm = int.parse(consumableCubit.remainingKmControllers
        .removeAt(oldIndex)
        .text
        .removeThousandSeparator());
    consumableCubit.lastChangedAtFocuses.removeAt(oldIndex);
    consumableCubit.changeIntervalFocuses.removeAt(oldIndex);
    consumableCubit.remainingKmFocuses.removeAt(oldIndex);

    currentList.insert(newIndex, itemModel);
    consumableCubit.lastChangedAtControllers.insert(
        newIndex, TextEditingController(text: lastChangedAt.toThousands()));
    consumableCubit.changeIntervalControllers.insert(
        newIndex, TextEditingController(text: changeInterval.toThousands()));
    consumableCubit.remainingKmControllers.insert(
        newIndex, TextEditingController(text: remainingKm.toThousands()));
    consumableCubit.lastChangedAtFocuses.insert(newIndex, FocusNode());
    consumableCubit.changeIntervalFocuses.insert(newIndex, FocusNode());
    consumableCubit.remainingKmFocuses.insert(newIndex, FocusNode());

    _consumableBox.put(AppKeys.consumableBox, currentList);
  }
}
