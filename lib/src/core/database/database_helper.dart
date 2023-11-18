import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
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
      ..registerAdapter<Car>(CarAdapter())
      ..registerAdapter<Consumable>(ConsumableAdapter());

    await Hive.openBox<Car>(AppKeys.carBox);
    await Hive.openBox<List>(AppKeys.consumableBox);

    if (di.sl<SharedPreferences>().getBool(AppKeys.prefsBoolListAdded) == null) {
      _consumableBox.put(AppKeys.consumableBox, []);

      for (int index = 0; index < AppLists.consumables.length; index++) {
        _consumableBox.get(AppKeys.consumableBox)!.add(
              Consumable(
                id: index,
                name: "${AppLists.consumablesEnglishList[index]}  ${AppLists.consumablesArabicList[index]}",
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

  /// Car
  static final Box<Car> _carBox = Hive.box<Car>(AppKeys.carBox);

  static Box<Car> get carBox => _carBox;

  static Future<bool> writeCarData(BuildContext context) async {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    CarCubit carCubit = CarCubit.get(context);
    bool isNotNull = true;

    _carBox.put(
      AppKeys.carBox,
      Car(
        type: carCubit.carTypeController.text,
        modelYear: int.parse(carCubit.modelYearController.text),
        currentKm: int.parse(carCubit.currentKmController.text.removeThousandSeparator()),
      ),
    );

    if (_carBox.get(AppKeys.carBox) == null) isNotNull = false;

    if (isNotNull) {
      prefs.setBool(AppKeys.prefsBoolSeen, true);
      BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }

    return prefs.getBool(AppKeys.prefsBoolSeen) ?? false;
  }

  /// Consumables
  static final Box<List> _consumableBox = Hive.box<List>(AppKeys.consumableBox);

  static Box<List> get consumableBox => _consumableBox;

  static Future<bool> writeConsumableName(BuildContext context, int index) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    if (consumableCubit.consumableNameController.text.isEmpty) {
      return false;
    } else {
      _consumableBox.get(AppKeys.consumableBox)![index].name = consumableCubit.consumableNameController.text;
      writeConsumablesData(context).then((value) => BotToast.showText(text: AppStrings.dataSavedSuccessfully(context)));
      return true;
    }
  }

  static Future<void> writeConsumablesData(BuildContext context) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    _carBox.put(
      AppKeys.carBox,
      Car(
        type: _carBox.get(AppKeys.carBox)!.type,
        modelYear: _carBox.get(AppKeys.carBox)!.modelYear,
        currentKm: int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()),
      ),
    );

    List<Consumable> list = [];

    for (int index = 0; index < Consumable.getCount(); index++) {
      _consumableBox.get(AppKeys.consumableBox)![index] = Consumable(
        id: index,
        name: _consumableBox.get(AppKeys.consumableBox)![index].name,
        lastChangedAt: consumableCubit.lastChangedAtControllers[index].text.isNotEmpty
            ? int.parse(consumableCubit.lastChangedAtControllers[index].text.removeThousandSeparator())
            : 0,
        changeInterval: consumableCubit.changeIntervalControllers[index].text.isNotEmpty
            ? int.parse(consumableCubit.changeIntervalControllers[index].text.removeThousandSeparator())
            : 0,
        remainingKm: consumableCubit.remainingKmControllers[index].text.isNotEmpty
            ? int.parse(consumableCubit.remainingKmControllers[index].text.removeThousandSeparator())
            : 0,
      );

      list.add(_consumableBox.get(AppKeys.consumableBox)![index]);
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

    _consumableBox.get(AppKeys.consumableBox)!.add(
          Consumable(
            id: _consumableBox.get(AppKeys.consumableBox)!.length,
            name: name,
            lastChangedAt: lastChangedAt,
            changeInterval: changeInterval,
            remainingKm: 0,
          ),
        );

    _consumableBox.put(AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers.add(TextEditingController(text: lastChangedAt.toThousands()));
    consumableCubit.changeIntervalControllers.add(TextEditingController(text: changeInterval.toThousands()));
    consumableCubit.remainingKmControllers.add(TextEditingController());

    consumableCubit.lastChangedAtFocuses.add(FocusNode());
    consumableCubit.changeIntervalFocuses.add(FocusNode());
    consumableCubit.remainingKmFocuses.add(FocusNode());

    return true;
  }

  static void resetConsumable(int index, BuildContext context) {
    List<Consumable> list = [];

    for (int i = 0; i < _consumableBox.get(AppKeys.consumableBox)!.length; i++) {
      list.add(_consumableBox.get(AppKeys.consumableBox)![i]);
    }

    list[index] = Consumable(id: list[index].id, name: list[index].name, lastChangedAt: 0, changeInterval: 0, remainingKm: 0);

    _consumableBox.put(AppKeys.consumableBox, list);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers[index].text = '';
    consumableCubit.changeIntervalControllers[index].text = '';
    consumableCubit.remainingKmControllers[index].text = '';

    BotToast.showText(text: AppStrings.resetItemSuccessfully(context));
  }

  static void removeConsumable(int index, BuildContext context) {
    _consumableBox.get(AppKeys.consumableBox)!.removeAt(index);
    _consumableBox.put(AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

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
    List<Consumable> list = [];

    for (int index = 0; index < _consumableBox.get(AppKeys.consumableBox)!.length; index++) {
      Consumable item = _consumableBox.get(AppKeys.consumableBox)![index];
      list.add(Consumable(id: item.id, name: item.name, lastChangedAt: 0, changeInterval: 0, remainingKm: 0));
      consumableCubit.lastChangedAtControllers[index].text = '';
      consumableCubit.changeIntervalControllers[index].text = '';
      consumableCubit.remainingKmControllers[index].text = '';
    }

    _consumableBox.put(AppKeys.consumableBox, list);

    BotToast.showText(text: AppStrings.resetAllCards(context));
  }

  static void removeAllCards(BuildContext context) {
    _consumableBox.get(AppKeys.consumableBox)!.clear();
    _consumableBox.put(AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers.clear();
    consumableCubit.changeIntervalControllers.clear();
    consumableCubit.remainingKmControllers.clear();

    consumableCubit.lastChangedAtFocuses.clear();
    consumableCubit.changeIntervalFocuses.clear();
    consumableCubit.remainingKmFocuses.clear();

    BotToast.showText(text: AppStrings.removedAllCards(context));
  }

  static void changeConsumableOrder(BuildContext context, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    Consumable item = _consumableBox.get(AppKeys.consumableBox)!.removeAt(oldIndex);
    int lastChangedAt = int.parse(consumableCubit.lastChangedAtControllers.removeAt(oldIndex).text.removeThousandSeparator());
    int changeInterval = int.parse(consumableCubit.changeIntervalControllers.removeAt(oldIndex).text.removeThousandSeparator());
    int remainingKm = int.parse(consumableCubit.remainingKmControllers.removeAt(oldIndex).text.removeThousandSeparator());
    consumableCubit.lastChangedAtFocuses.removeAt(oldIndex);
    consumableCubit.changeIntervalFocuses.removeAt(oldIndex);
    consumableCubit.remainingKmFocuses.removeAt(oldIndex);

    _consumableBox.get(AppKeys.consumableBox)!.insert(newIndex, item);
    consumableCubit.lastChangedAtControllers.insert(newIndex, TextEditingController(text: lastChangedAt.toThousands()));
    consumableCubit.changeIntervalControllers.insert(newIndex, TextEditingController(text: changeInterval.toThousands()));
    consumableCubit.remainingKmControllers.insert(newIndex, TextEditingController(text: remainingKm.toThousands()));
    consumableCubit.lastChangedAtFocuses.insert(newIndex, FocusNode());
    consumableCubit.changeIntervalFocuses.insert(newIndex, FocusNode());
    consumableCubit.remainingKmFocuses.insert(newIndex, FocusNode());

    _consumableBox.put(AppKeys.consumableBox, _consumableBox.get(AppKeys.consumableBox)!);
  }
}
