import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/dialogs/warning_dialog.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogHelper {
  static Future<bool> showOnWillPopDialogs(BuildContext context) async {
    String debugMsg = "onWillPop\n\n";

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    if (consumableCubit.shouldEnableButtons(context) == false && Consumable.getCount() != 0) {
      debugMsg += "${consumableCubit.shouldEnableButtons(context)}";
      _showOnWillPopInvalidDataDialog(context);
      return false;
    }

    for (int index = 0; index < Consumable.getCount(); index++) {
      Car? car = DatabaseHelper.carBox.get(AppStrings.carBox);
      Consumable? consumable = DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index];

      if (int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) !=
          car!.currentKm) {
        debugMsg += "Case 1\n";
        debugMsg +=
            "int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) ==> ${int.parse(consumableCubit.currentKmController.text.removeThousandSeparator())}\n";
        debugMsg += "car!.currentKm ==> ${car.currentKm}\n";
        debugMsg += "\n";
        _showOnWillPopChangedDataDialog(context);
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
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          return false;
        }
      }

      if (consumable != null) {
        debugMsg += "Case 3\n"
            // ignore: unnecessary_null_comparison
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
          _showOnWillPopChangedDataDialog(context);
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
          _showOnWillPopChangedDataDialog(context);
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
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          return false;
        }
      }
    }
    debugPrint(debugMsg);
    return true;
  }

  static void _showOnWillPopChangedDataDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.changedDataMsg(context),
          content: AppStrings.sureToExitMsg(context),
          positiveAction: () => DatabaseHelper.writeConsumablesData(context).then((value) {
            BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
            SystemNavigator.pop();
          }),
          positiveText: AppStrings.saveData(context),
          negativeAction: () => SystemNavigator.pop(),
          negativeText: AppStrings.exitWithoutSaving(context),
          neutralAction: () => Navigator.pop(context),
          neutralText: AppStrings.cancel(context),
        ),
      );

  static void _showOnWillPopInvalidDataDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => WarningDialog(
            title: AppStrings.invalidDataDialogTitle(context),
            content: AppStrings.invalidDataDialogContent(context),
            positiveAction: () => Navigator.pop(context),
            positiveText: AppStrings.invalidDataDialogPositiveText(context),
            negativeAction: () => SystemNavigator.pop(),
            negativeText: AppStrings.invalidDataDialogNegativeText(context),
          ));

  static void showRemoveConsumableConfirmationDialog(BuildContext context, int index) => showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removingItem(context, index),
          content: AppStrings.sureToDeleteMsg(context),
          positiveAction: () {
            DatabaseHelper.removeConsumable(index, context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.removeItem(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );

  static void showRemoveAllDataConfirmationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => WarningDialog(
            title: AppStrings.removeAllDataConfirmationDialogTitle(context),
            content: AppStrings.removeAllDataConfirmationDialogContent(context),
            positiveAction: () {
              Navigator.pop(context);
              _showRemoveAllDataAssuringDialog(context);
            },
            positiveText: AppStrings.proceed(context),
            negativeAction: () => Navigator.pop(context),
            negativeText: AppStrings.cancel(context),
          ));

  static void _showRemoveAllDataAssuringDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removeAllDataAssuringDialogTitle(context).toUpperCase(),
          content: AppStrings.removeAllDataAssuringDialogContent(context),
          positiveAction: () {
            DatabaseHelper.removeAllData(context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.eraseData(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );
}
