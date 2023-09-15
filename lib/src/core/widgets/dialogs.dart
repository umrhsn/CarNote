import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Dialogs {
  static void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AnimationConfiguration.synchronized(
        child: SlideAnimation(
          child: FadeInAnimation(
            child: AlertDialog(
              icon: const Icon(Icons.warning_rounded, color: Colors.red, size: 50),
              title: Text(AppStrings.changedDataMsg(context)),
              content: Text(AppStrings.sureToExitMsg(context)),
              actions: [
                TextButton(
                  onPressed: () => DatabaseHelper.writeConsumablesData(context).then((value) {
                    BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
                    SystemNavigator.pop();
                  }),
                  child: Text(AppStrings.saveData(context)),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(AppStrings.exitWithoutSaving(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<bool> onWillPop(BuildContext context) async {
    ConsumableCubit consumableCubit = ConsumableCubit.get(context);
    if (consumableCubit.shouldEnableAddButton(context) == false) return true;

    String debugMsg = "onWillPop\n\n";

    for (int index = 0; index < Consumable.getCount(); index++) {
      Car? car = DatabaseHelper.carBox.get(AppStrings.carBox);
      Consumable? consumable = DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index];

      if (int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) !=
          car!.currentKm) {
        debugPrint("Case 1");
        debugPrint(
            "int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) ==> ${int.parse(consumableCubit.currentKmController.text.removeThousandSeparator())}");
        debugPrint("car!.currentKm ==> ${car.currentKm}");
        debugPrint("\n");
        _showExitDialog(context);
        debugPrint(debugMsg);
        return false;
      }

      if (consumable == null) {
        debugMsg += "Case 2\n"
            "consumable == null ==> ${consumable == null}\n\n";
        if (consumableCubit.lastChangedAtControllers[index].text.isNotEmpty ||
            consumableCubit.changeIntervalControllers[index].text.isNotEmpty ||
            consumableCubit.remainingKmControllers[index].text.isNotEmpty) {
          debugMsg +=
              "consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty ==> ${consumableCubit.lastChangedAtControllers[index].text.isNotEmpty}\n"
              "consumableCubit.changeIntervalControllers[$index].text.isNotEmpty ==> ${consumableCubit.changeIntervalControllers[index].text.isNotEmpty}\n"
              "consumableCubit.remainingKmControllers[$index].text.isNotEmpty ==> ${consumableCubit.remainingKmControllers[index].text.isNotEmpty}\n\n";
          _showExitDialog(context);
          debugPrint(debugMsg);
          return false;
        }
      }

      if (consumable != null) {
        debugMsg += "Case 3\n"
            "consumable != null ==> ${consumable != null}\n\n";

        if ((consumable.lastChangedAt == 0 &&
                consumableCubit.lastChangedAtControllers[index].text.isNotEmpty) ||
            (consumable.changeInterval == 0 &&
                consumableCubit.changeIntervalControllers[index].text.isNotEmpty) ||
            (consumable.remainingKm == 0 &&
                consumableCubit.remainingKmControllers[index].text.isNotEmpty)) {
          debugMsg += "Case 3.1\n"
              "(consumable.lastChangedAt == 0 && consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty) ==> ${(consumable.lastChangedAt == 0 && consumableCubit.lastChangedAtControllers[index].text.isNotEmpty)}\n"
              "(consumable.changeInterval == 0 && consumableCubit.changeIntervalControllers[$index].text.isNotEmpty) ==> ${(consumable.changeInterval == 0 && consumableCubit.changeIntervalControllers[index].text.isNotEmpty)}\n"
              "(consumable.remainingKm == 0 && consumableCubit.remainingKmControllers[$index].text.isNotEmpty) ==> ${(consumable.remainingKm == 0 && consumableCubit.remainingKmControllers[index].text.isNotEmpty)}\n\n";
          _showExitDialog(context);
          debugPrint(debugMsg);
          return false;
        }

        if ((consumableCubit.lastChangedAtControllers[index].text.isEmpty &&
                consumable.lastChangedAt != 0) ||
            (consumableCubit.changeIntervalControllers[index].text.isEmpty &&
                consumable.changeInterval != 0) ||
            (consumableCubit.remainingKmControllers[index].text.isEmpty &&
                consumable.remainingKm != 0)) {
          debugMsg += "Case 3.2\n"
              "(consumableCubit.lastChangedAtControllers[$index].text.isEmpty && consumable.lastChangedAt != 0) ==> ${(consumableCubit.lastChangedAtControllers[index].text.isEmpty && consumable.lastChangedAt != 0)}\n"
              "(consumableCubit.changeIntervalControllers[$index].text.isEmpty && consumable.changeInterval != 0) ==> ${(consumableCubit.changeIntervalControllers[index].text.isEmpty && consumable.changeInterval != 0)}\n"
              "(consumableCubit.remainingKmControllers[$index].text.isEmpty && consumable.remainingKm != 0) ==> ${(consumableCubit.remainingKmControllers[index].text.isEmpty && consumable.remainingKm != 0)}\n\n";
          _showExitDialog(context);
          debugPrint(debugMsg);
          return false;
        }

        if ((consumableCubit.lastChangedAtControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.lastChangedAtControllers[index].text
                        .removeThousandSeparator()) !=
                    consumable.lastChangedAt) ||
            (consumableCubit.changeIntervalControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.changeIntervalControllers[index].text
                        .removeThousandSeparator()) !=
                    consumable.changeInterval) ||
            (consumableCubit.remainingKmControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.remainingKmControllers[index].text
                        .removeThousandSeparator()) !=
                    consumable.remainingKm)) {
          debugMsg += "Case 3.3\n"
              "(consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty && int.parse(consumableCubit.lastChangedAtControllers[$index].text.removeThousandSeparator()) != consumable.lastChangedAt) ==> ${(consumableCubit.lastChangedAtControllers[index].text.isNotEmpty && int.parse(consumableCubit.lastChangedAtControllers[index].text.removeThousandSeparator()) != consumable.lastChangedAt)}\n"
              "(consumableCubit.changeIntervalControllers[$index].text.isNotEmpty && int.parse(consumableCubit.changeIntervalControllers[$index].text.removeThousandSeparator()) != consumable.changeInterval) ==> ${(consumableCubit.changeIntervalControllers[index].text.isNotEmpty && int.parse(consumableCubit.changeIntervalControllers[index].text.removeThousandSeparator()) != consumable.changeInterval)}\n"
              "(consumableCubit.remainingKmControllers[$index].text.isNotEmpty && int.parse(consumableCubit.remainingKmControllers[$index].text.removeThousandSeparator()) != consumable.remainingKm) ==> ${(consumableCubit.remainingKmControllers[index].text.isNotEmpty && int.parse(consumableCubit.remainingKmControllers[index].text.removeThousandSeparator()) != consumable.remainingKm)}\n\n";
          _showExitDialog(context);
          debugPrint(debugMsg);
          return false;
        }
      }
    }
    debugPrint(debugMsg);
    return true;
  }

  static void showRemoveConsumableConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AnimationConfiguration.synchronized(
        child: SlideAnimation(
          child: FadeInAnimation(
            child: AlertDialog(
              icon: const Icon(Icons.warning_rounded, size: 50),
              title: Text(AppStrings.removingItem(context, index)),
              content: Text(AppStrings.sureToDeleteMsg(context)),
              actions: [
                TextButton(
                  onPressed: () {
                    DatabaseHelper.removeConsumable(index, context);
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.removeItem(context)),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppStrings.cancel(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showRemoveAllDataConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AnimationConfiguration.synchronized(
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: AlertDialog(
                    icon: const Icon(Icons.warning_rounded, size: 50),
                    title: Text(AppStrings.removeAllDataConfirmationDialogTitle(context)),
                    content: Text(AppStrings.removeAllDataConfirmationDialogContent(context)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showRemoveAllDataAssuringDialog(context);
                        },
                        child: Text(AppStrings.proceed(context).toUpperCase()),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppStrings.cancel(context).toUpperCase()),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  static void showRemoveAllDataAssuringDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AnimationConfiguration.synchronized(
        child: SlideAnimation(
          child: FadeInAnimation(
            child: AlertDialog(
              icon: const Icon(Icons.warning_rounded, size: 50),
              title: Text(AppStrings.removeAllDataAssuringDialogTitle(context).toUpperCase()),
              content: Text(AppStrings.removeAllDataAssuringDialogContent(context)),
              actions: [
                TextButton(
                  onPressed: () {
                    DatabaseHelper.removeAllData(context);
                    Navigator.pop(context);
                  },
                  child: Text(AppStrings.eraseData(context).toUpperCase()),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(AppStrings.cancel(context).toUpperCase()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
