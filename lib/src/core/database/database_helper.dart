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
      BotToast.showText(text: AppStrings.dataAddedSuccessfully(context));
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }

    return prefs.getBool(AppStrings.prefsBoolSeen) ?? false;
  }

  /// Consumables
  static final Box<List> _consumableBox = Hive.box<List>(AppStrings.consumableBox);
  static Box<List> get consumableBox => _consumableBox;

  static Future<void> writeConsumablesData(BuildContext context) async {
    debugPrint(writeConsumablesData.getMethodName());

    SharedPreferences prefs = di.sl<SharedPreferences>();
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    _carBox.put(
      AppStrings.carBox,
      Car(
        type: _carBox.get(AppStrings.carBox)!.type,
        modelYear: _carBox.get(AppStrings.carBox)!.modelYear,
        currentKm: int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()),
      ),
    );

    bool listAdded = prefs.getBool(AppStrings.prefsBoolListAdded) ?? false;

    List<Consumable> consumablesList = [];

    for (int index = 0; index < Consumable.getCount(); index++) {
      consumablesList.add(Consumable(
        id: index,
        name: listAdded
            ? _consumableBox.get(AppStrings.consumablesKey)![index].name
            : AppStrings.consumables[index],
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
      ));
    }

    _consumableBox
        .put("consumables", consumablesList)
        .then((value) => prefs.setBool(AppStrings.prefsBoolListAdded, true));
    BotToast.showText(text: AppStrings.dataAddedSuccessfully(context));
  }

  static void addConsumable({
    required String name,
    required int lastChangedAt,
    required int changeInterval,
  }) =>
      _consumableBox.get(AppStrings.consumablesKey)!.add(
            Consumable(
              id: _consumableBox.length,
              name: name,
              lastChangedAt: lastChangedAt,
              changeInterval: changeInterval,
              remainingKm: 0,
            ),
          );

  static void removeConsumable(int index) =>
      _consumableBox.get(AppStrings.consumablesKey)!.removeAt(index);
}
