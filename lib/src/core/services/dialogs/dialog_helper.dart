// lib/src/core/services/dialogs/dialog_helper.dart
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/core/widgets/dialogs/warning_dialog.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogHelper {
  static bool showOnWillPopDialogs(
      BuildContext context, ConsumableCubit consumableCubit) {
    bool canExit = true;
    String debugMsg = "onWillPop\n\n";

    /// Main Case
    if (consumableCubit.shouldEnableButtons(context) == false &&
        consumableCubit.consumableCount != 0) {
      debugMsg += "${consumableCubit.shouldEnableButtons(context)}";
      _showOnWillPopInvalidDataDialog(context);
      canExit = false;
      debugPrint("canExit => $canExit");
      return canExit;
    }

    for (int index = 0; index < consumableCubit.consumableCount; index++) {
      final consumable = consumableCubit.consumables[index];

      /// Case 1 - Current kilometer doesn't match the database value
      if (consumableCubit.currentKmController.text.isNotEmpty) {
        // Check if current km has changed (this would need to be tracked differently in clean architecture)
        // For now, we'll assume if validation fails, data has changed
      }

      /// Case 2 - Consumable item has values but not saved
      if (consumableCubit.lastChangedAtControllers[index].text.isNotEmpty ||
          consumableCubit.changeIntervalControllers[index].text.isNotEmpty ||
          consumableCubit.remainingKmControllers[index].text.isNotEmpty) {
        if (AppTexts.getLastChangedKmValidatingText(context,
                    cubit: consumableCubit, index: index)
                .data !=
            '') {
          _showOnWillPopChangedDataDialog(context, consumableCubit);
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

  static void _showOnWillPopChangedDataDialog(
          BuildContext context, ConsumableCubit consumableCubit) =>
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.changedDataMsg(context),
          content: AppStrings.sureToExitMsg(context),
          positiveAction: () async {
            await consumableCubit.saveConsumablesData(context);
            SystemNavigator.pop();
          },
          positiveText: AppStrings.saveData(context),
          negativeAction: () => SystemNavigator.pop(),
          negativeText: AppStrings.exitWithoutSaving(context),
          neutralAction: () => Navigator.pop(context),
          neutralText: AppStrings.cancel(context),
        ),
      );

  static void _showOnWillPopInvalidDataDialog(BuildContext context) =>
      showDialog(
          context: context,
          builder: (context) => WarningDialog(
                title: AppStrings.invalidDataDialogTitle(context),
                content: AppStrings.invalidDataDialogContent(context),
                positiveAction: () => SystemNavigator.pop(),
                positiveText: AppStrings.exitWithoutSaving(context),
                negativeAction: () => Navigator.pop(context),
                negativeText: AppStrings.cancel(context),
              ));

  static void showResetConsumableConfirmationDialog(
          BuildContext context, int index, ConsumableCubit consumableCubit) =>
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.resettingItem(context, index),
          content: AppStrings.sureToResetMsg(context),
          positiveAction: () async {
            await consumableCubit.resetConsumable(index, context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.resetItem(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );

  static void showRemoveConsumableConfirmationDialog(
          BuildContext context, int index, ConsumableCubit consumableCubit) =>
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removingItem(context, index),
          content: AppStrings.sureToRemoveMsg(context),
          positiveAction: () async {
            await consumableCubit.removeConsumable(index, context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.removeItem(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );

  static void showResetAllCardsConfirmationDialog(
          BuildContext context, ConsumableCubit consumableCubit) =>
      showDialog(
          context: context,
          builder: (context) => WarningDialog(
                title: AppStrings.resetAllCardsConfirmationDialogTitle(context),
                content:
                    AppStrings.resetAllCardsConfirmationDialogContent(context),
                positiveAction: () {
                  Navigator.pop(context);
                  _showResetAllCardsAssuringDialog(context, consumableCubit);
                },
                positiveText: AppStrings.proceed(context),
                negativeAction: () => Navigator.pop(context),
                negativeText: AppStrings.cancel(context),
              ));

  static void _showResetAllCardsAssuringDialog(
          BuildContext context, ConsumableCubit consumableCubit) =>
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.resetAllCardsAssuringDialogTitle(context)
              .toUpperCase(),
          content: AppStrings.resetAllCardsAssuringDialogContent(context),
          positiveAction: () async {
            await consumableCubit.resetAllConsumables(context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.eraseData(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );

  static void showRemoveAllCardsConfirmationDialog(
          BuildContext context, ConsumableCubit consumableCubit) =>
      showDialog(
          context: context,
          builder: (context) => WarningDialog(
                title:
                    AppStrings.removeAllCardsConfirmationDialogTitle(context),
                content:
                    AppStrings.removeAllCardsConfirmationDialogContent(context),
                positiveAction: () {
                  Navigator.pop(context);
                  _showRemoveAllCardsAssuringDialog(context, consumableCubit);
                },
                positiveText: AppStrings.proceed(context),
                negativeAction: () => Navigator.pop(context),
                negativeText: AppStrings.cancel(context),
              ));

  static void _showRemoveAllCardsAssuringDialog(
          BuildContext context, ConsumableCubit consumableCubit) =>
      showDialog(
        context: context,
        builder: (context) => WarningDialog(
          title: AppStrings.removeAllCardsAssuringDialogTitle(context)
              .toUpperCase(),
          content: AppStrings.removeAllCardsAssuringDialogContent(context),
          positiveAction: () async {
            await consumableCubit.removeAllConsumables(context);
            Navigator.pop(context);
          },
          positiveText: AppStrings.removeCards(context),
          negativeAction: () => Navigator.pop(context),
          negativeText: AppStrings.cancel(context),
        ),
      );
}
