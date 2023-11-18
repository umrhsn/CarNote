import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/dialogs/warning_dialog.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogHelper {
  static Future<bool> showOnWillPopDialogs(BuildContext context) async {
    bool canExit = true;
    String debugMsg = "onWillPop\n\n";

    ConsumableCubit consumableCubit = ConsumableCubit.get(context);

    /// Main Case
    //
    if (consumableCubit.shouldEnableButtons(context) == false && Consumable.getCount() != 0) {
      debugMsg += "${consumableCubit.shouldEnableButtons(context)}";
      _showOnWillPopInvalidDataDialog(context);
      canExit = false;
      debugPrint("canExit => $canExit");
      return canExit;
    }

    for (int index = 0; index < Consumable.getCount(); index++) {
      Car? car = DatabaseHelper.carBox.get(AppKeys.carBox);
      Consumable? consumable = DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index];

      /// Case 1
      // Current kilometer doesn't match the database value
      if (int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()) != car!.currentKm) {
        debugMsg += "Case 1\n";
        debugMsg +=
            "consumableCubit.currentKmController.text ==> ${int.parse(consumableCubit.currentKmController.text.removeThousandSeparator()).toThousands()}\n";
        debugMsg += "car.currentKm ==> ${car.currentKm.toThousands()}\n";
        debugMsg += "\n";
        _showOnWillPopChangedDataDialog(context);
        debugPrint(debugMsg);
        canExit = false;
        debugPrint("canExit => $canExit");
        return canExit;
      }

      /// Case 2
      if (consumable == null) {
        debugMsg += "Case 2\n"
            "consumable == null ==> ${consumable == null}\n\n";
        // Consumable item has not yet been saved to database but controller has a value
        if (consumableCubit.lastChangedAtControllers[index].text.isNotEmpty ||
            consumableCubit.changeIntervalControllers[index].text.isNotEmpty ||
            consumableCubit.remainingKmControllers[index].text.isNotEmpty) {
          debugMsg +=
              "consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty ==> ${consumableCubit.lastChangedAtControllers[index].text.isNotEmpty}\n"
              "consumableCubit.changeIntervalControllers[$index].text.isNotEmpty ==> ${consumableCubit.changeIntervalControllers[index].text.isNotEmpty}\n"
              "consumableCubit.remainingKmControllers[$index].text.isNotEmpty ==> ${consumableCubit.remainingKmControllers[index].text.isNotEmpty}\n\n";
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          canExit = false;
          debugPrint("canExit => $canExit");
          return canExit;
        }
      }

      /// Case 3
      // Consumable item has been saved to database
      if (consumable != null) {
        debugMsg += "Case 3\n"
            // ignore: unnecessary_null_comparison
            "consumable != null ==> ${consumable != null}\n\n";

        /// Case 3.1
        // Controller has a value but the database value is 0
        if ((consumable.lastChangedAt == 0 && consumableCubit.lastChangedAtControllers[index].text.isNotEmpty) ||
            (consumable.changeInterval == 0 && consumableCubit.changeIntervalControllers[index].text.isNotEmpty)) {
          debugMsg += "Case 3.1\n"
              "consumable.lastChangedAt[$index] == 0 ==> ${consumable.lastChangedAt == 0}\n"
              "consumable.changeInterval[$index] == 0 ==> ${consumable.changeInterval == 0}\n"
              "consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty ==> ${consumableCubit.lastChangedAtControllers[index].text.isNotEmpty}\n"
              "consumableCubit.changeIntervalControllers[$index].text.isNotEmpty ==> ${consumableCubit.changeIntervalControllers[index].text.isNotEmpty}\n"
              "(consumable.lastChangedAt == 0 && consumableCubit.lastChangedAtControllers[index].text.isNotEmpty) ==> ${(consumable.lastChangedAt == 0 && consumableCubit.lastChangedAtControllers[index].text.isNotEmpty)}\n"
              "(consumable.changeInterval == 0 && consumableCubit.changeIntervalControllers[index].text.isNotEmpty) ==> ${(consumable.changeInterval == 0 && consumableCubit.changeIntervalControllers[index].text.isNotEmpty)}\n\n";
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          canExit = false;
          debugPrint("canExit => $canExit");
          return canExit;
        }

        /// Case 3.2
        // Controller is empty but the database value is not 0
        if ((consumableCubit.lastChangedAtControllers[index].text.isEmpty && consumable.lastChangedAt != 0) ||
            (consumableCubit.changeIntervalControllers[index].text.isEmpty && consumable.changeInterval != 0) ||
            (consumableCubit.remainingKmControllers[index].text.isEmpty && consumable.remainingKm != 0)) {
          debugMsg += "Case 3.2\n"
              "(consumableCubit.lastChangedAtControllers[$index].text.isEmpty && consumable.lastChangedAt != 0) ==> ${(consumableCubit.lastChangedAtControllers[index].text.isEmpty && consumable.lastChangedAt != 0)}\n"
              "(consumableCubit.changeIntervalControllers[$index].text.isEmpty && consumable.changeInterval != 0) ==> ${(consumableCubit.changeIntervalControllers[index].text.isEmpty && consumable.changeInterval != 0)}\n"
              "(consumableCubit.remainingKmControllers[$index].text.isEmpty && consumable.remainingKm != 0) ==> ${(consumableCubit.remainingKmControllers[index].text.isEmpty && consumable.remainingKm != 0)}\n\n";
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          canExit = false;
          debugPrint("canExit => $canExit");
          return canExit;
        }

        /// Case 3.3
        // Controller has a value but doesn't match the database value
        if ((consumableCubit.lastChangedAtControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.lastChangedAtControllers[index].text.removeThousandSeparator()) != consumable.lastChangedAt) ||
            (consumableCubit.changeIntervalControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.changeIntervalControllers[index].text.removeThousandSeparator()) != consumable.changeInterval) ||
            (consumableCubit.remainingKmControllers[index].text.isNotEmpty &&
                int.parse(consumableCubit.remainingKmControllers[index].text.removeThousandSeparator()) != consumable.remainingKm)) {
          debugMsg += "Case 3.3\n"
              "(consumableCubit.lastChangedAtControllers[$index].text.isNotEmpty && int.parse(consumableCubit.lastChangedAtControllers[$index].text.removeThousandSeparator()) != consumable.lastChangedAt) ==> ${(consumableCubit.lastChangedAtControllers[index].text.isNotEmpty && int.parse(consumableCubit.lastChangedAtControllers[index].text.removeThousandSeparator()) != consumable.lastChangedAt)}\n"
              "(consumableCubit.changeIntervalControllers[$index].text.isNotEmpty && int.parse(consumableCubit.changeIntervalControllers[$index].text.removeThousandSeparator()) != consumable.changeInterval) ==> ${(consumableCubit.changeIntervalControllers[index].text.isNotEmpty && int.parse(consumableCubit.changeIntervalControllers[index].text.removeThousandSeparator()) != consumable.changeInterval)}\n"
              "(consumableCubit.remainingKmControllers[$index].text.isNotEmpty && int.parse(consumableCubit.remainingKmControllers[$index].text.removeThousandSeparator()) != consumable.remainingKm) ==> ${(consumableCubit.remainingKmControllers[index].text.isNotEmpty && int.parse(consumableCubit.remainingKmControllers[index].text.removeThousandSeparator()) != consumable.remainingKm)}\n\n";
          _showOnWillPopChangedDataDialog(context);
          debugPrint(debugMsg);
          canExit = false;
          debugPrint("canExit => $canExit");
          return canExit;
        }
      }
    }
    debugPrint(debugMsg);
    debugPrint("canExit => $canExit");
    return canExit;
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
            positiveAction: () => SystemNavigator.pop(),
            positiveText: AppStrings.exitWithoutSaving(context),
            negativeAction: () => Navigator.pop(context),
            negativeText: AppStrings.cancel(context),
          ));

  static void showResetConsumableConfirmationDialog(BuildContext context, int index) => showDialog(
    context: context,
    builder: (context) => WarningDialog(
      title: AppStrings.resettingItem(context, index),
      content: AppStrings.sureToResetMsg(context),
      positiveAction: () {
        DatabaseHelper.resetConsumable(index, context);
        Navigator.pop(context);
      },
      positiveText: AppStrings.resetItem(context),
      negativeAction: () => Navigator.pop(context),
      negativeText: AppStrings.cancel(context),
    ),
  );

  static void showRemoveConsumableConfirmationDialog(BuildContext context, int index) => showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removingItem(context, index),
          content: AppStrings.sureToRemoveMsg(context),
          positiveAction: () {
            DatabaseHelper.removeConsumable(index, context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.removeItem(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );

  static void showResetAllCardsConfirmationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => WarningDialog(
        title: AppStrings.resetAllCardsConfirmationDialogTitle(context),
        content: AppStrings.resetAllCardsConfirmationDialogContent(context),
        positiveAction: () {
          Navigator.pop(context);
          _showResetAllCardsAssuringDialog(context);
        },
        positiveText: AppStrings.proceed(context),
        negativeAction: () => Navigator.pop(context),
        negativeText: AppStrings.cancel(context),
      ));

  static void _showResetAllCardsAssuringDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) => WarningDialog(
      title: AppStrings.resetAllCardsAssuringDialogTitle(context).toUpperCase(),
      content: AppStrings.resetAllCardsAssuringDialogContent(context),
      positiveAction: () {
        DatabaseHelper.resetAllCards(context);
        Navigator.pop(context);
      },
      positiveText: AppStrings.eraseData(context),
      negativeAction: () => Navigator.pop(context),
      negativeText: AppStrings.cancel(context),
    ),
  );

  static void showRemoveAllCardsConfirmationDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => WarningDialog(
            title: AppStrings.removeAllCardsConfirmationDialogTitle(context),
            content: AppStrings.removeAllCardsConfirmationDialogContent(context),
            positiveAction: () {
              Navigator.pop(context);
              _showRemoveAllCardsAssuringDialog(context);
            },
            positiveText: AppStrings.proceed(context),
            negativeAction: () => Navigator.pop(context),
            negativeText: AppStrings.cancel(context),
          ));

  static void _showRemoveAllCardsAssuringDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removeAllCardsAssuringDialogTitle(context).toUpperCase(),
          content: AppStrings.removeAllCardsAssuringDialogContent(context),
          positiveAction: () {
            DatabaseHelper.removeAllCards(context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.removeCards(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );
}
