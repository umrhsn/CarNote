import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class DatabaseHelper {
  /// Car
  static final Box<Car> _carBox = Hive.box<Car>(AppStrings.carBox);

  static Box<Car> get carBox => _carBox;

  static Future<bool> writeCarData(BuildContext context) async {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    CarCubit carCubit = CarCubit.get(context);
    bool isNotNull = true;

    _carBox.put(
      AppStrings.carBox,
      Car(
        type: carCubit.carTypeController.text,
        modelYear: int.parse(carCubit.modelYearController.text),
        currentKm: int.parse(carCubit.currentKmController.text.removeThousandSeparator()),
      ),
    );

    if (_carBox.get(AppStrings.carBox) == null) isNotNull = false;

    if (isNotNull) {
      prefs.setBool(AppStrings.prefsBoolSeen, true);
      BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }

    return prefs.getBool(AppStrings.prefsBoolSeen) ?? false;
  }

  /// Consumables
  static final Box<List> _consumableBox = Hive.box<List>(AppStrings.consumableBox);

  static Box<List> get consumableBox => _consumableBox;

  static Future<bool> writeConsumableName(BuildContext context, int index) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    if (consumableCubit.consumableNameController.text.isEmpty) {
      return false;
    } else {
      _consumableBox.get(AppStrings.consumableBox)![index].name =
          consumableCubit.consumableNameController.text;
      writeConsumablesData(context)
          .then((value) => BotToast.showText(text: AppStrings.dataSavedSuccessfully(context)));
      return true;
    }
  }

  static Future<void> writeConsumablesData(BuildContext context) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    _carBox.put(
      AppStrings.carBox,
      Car(
        type: _carBox.get(AppStrings.carBox)!.type,
        modelYear: _carBox.get(AppStrings.carBox)!.modelYear,
        currentKm: int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()),
      ),
    );

    List<Consumable> list = [];

    for (int index = 0; index < Consumable.getCount(); index++) {
      _consumableBox.get(AppStrings.consumableBox)![index] = Consumable(
        id: index,
        name: _consumableBox.get(AppStrings.consumableBox)![index].name,
        lastChangedAt: consumableCubit.lastChangedAtControllers[index].text.isNotEmpty
            ? int.parse(
                consumableCubit.lastChangedAtControllers[index].text.removeThousandSeparator())
            : 0,
        changeInterval: consumableCubit.changeIntervalControllers[index].text.isNotEmpty
            ? int.parse(
                consumableCubit.changeIntervalControllers[index].text.removeThousandSeparator())
            : 0,
        remainingKm: consumableCubit.remainingKmControllers[index].text.isNotEmpty
            ? int.parse(
                consumableCubit.remainingKmControllers[index].text.removeThousandSeparator())
            : 0,
      );

      list.add(_consumableBox.get(AppStrings.consumableBox)![index]);
    }

    _consumableBox.put(AppStrings.consumableBox, list);
  }

  static Future<bool> addConsumable(
    BuildContext context, {
    required String name,
    required int lastChangedAt,
    required int changeInterval,
  }) async {
    if (name.isEmpty || lastChangedAt == 0 || changeInterval == 0) return false;

    _consumableBox.get(AppStrings.consumableBox)!.add(
          Consumable(
            id: _consumableBox.get(AppStrings.consumableBox)!.length,
            name: name,
            lastChangedAt: lastChangedAt,
            changeInterval: changeInterval,
            remainingKm: 0,
          ),
        );

    _consumableBox.put(AppStrings.consumableBox, _consumableBox.get(AppStrings.consumableBox)!);

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

  static void removeConsumable(int index, BuildContext context) {
    _consumableBox.get(AppStrings.consumableBox)!.removeAt(index);
    _consumableBox.put(AppStrings.consumableBox, _consumableBox.get(AppStrings.consumableBox)!);

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    consumableCubit.lastChangedAtControllers.removeAt(index);
    consumableCubit.changeIntervalControllers.removeAt(index);
    consumableCubit.remainingKmControllers.removeAt(index);

    consumableCubit.lastChangedAtFocuses.removeAt(index);
    consumableCubit.changeIntervalFocuses.removeAt(index);
    consumableCubit.remainingKmFocuses.removeAt(index);

    BotToast.showText(text: AppStrings.removedItem(context));
  }

  static void changeConsumableOrder(BuildContext context, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex -= 1;
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    Consumable item = _consumableBox.get(AppStrings.consumableBox)!.removeAt(oldIndex);
    int lastChangedAt = int.parse(
        consumableCubit.lastChangedAtControllers.removeAt(oldIndex).text.removeThousandSeparator());
    int changeInterval = int.parse(consumableCubit.changeIntervalControllers
        .removeAt(oldIndex)
        .text
        .removeThousandSeparator());
    int remainingKm = int.parse(
        consumableCubit.remainingKmControllers.removeAt(oldIndex).text.removeThousandSeparator());
    consumableCubit.lastChangedAtFocuses.removeAt(oldIndex);
    consumableCubit.changeIntervalFocuses.removeAt(oldIndex);
    consumableCubit.remainingKmFocuses.removeAt(oldIndex);

    _consumableBox.get(AppStrings.consumableBox)!.insert(newIndex, item);
    consumableCubit.lastChangedAtControllers
        .insert(newIndex, TextEditingController(text: lastChangedAt.toThousands()));
    consumableCubit.changeIntervalControllers
        .insert(newIndex, TextEditingController(text: changeInterval.toThousands()));
    consumableCubit.remainingKmControllers
        .insert(newIndex, TextEditingController(text: remainingKm.toThousands()));
    consumableCubit.lastChangedAtFocuses.insert(newIndex, FocusNode());
    consumableCubit.changeIntervalFocuses.insert(newIndex, FocusNode());
    consumableCubit.remainingKmFocuses.insert(newIndex, FocusNode());

    _consumableBox.put(AppStrings.consumableBox, _consumableBox.get(AppStrings.consumableBox)!);
  }
}
