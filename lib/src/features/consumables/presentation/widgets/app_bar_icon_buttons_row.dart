// lib/src/features/consumables/presentation/widgets/app_bar_icon_buttons_row.dart
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/services/file/file_service.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/core/widgets/buttons/animated_icon_button.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class AppBarIconButtonsRow extends StatelessWidget {
  AppBarIconButtonsRow({
    super.key,
    required this.localeCubit,
    required this.consumableCubit,
  });

  final LocaleCubit localeCubit;
  final ConsumableCubit consumableCubit;
  final SharedPreferences _prefs = di.sl<SharedPreferences>();

  bool _getVisibilityStatus() {
    if (_prefs.getBool(AppKeys.prefsBoolDetailedModeOn) == null) {
      _prefs.setBool(AppKeys.prefsBoolDetailedModeOn, true);
    }
    bool visible = _prefs.getBool(AppKeys.prefsBoolDetailedModeOn) ?? true;
    return visible;
  }

  @override
  Widget build(BuildContext context) {
    final hasConsumables = consumableCubit.consumableCount > 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyMyCars,
            icon: MdiIcons.carMultiple,
            onPressed: () => Navigator.pushNamed(context, Routes.myCarsRoute),
            tooltip: AppStrings.myCarsTooltip(context),
          ),
        ),
        const Spacer(),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyToggleDetailedMode,
            btnEnabled: hasConsumables,
            icon: _getVisibilityStatus() ? MdiIcons.eye : MdiIcons.eyeOutline,
            onPressed: () => consumableCubit.changeVisibility(context),
            tooltip: AppStrings.toggleModeTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keySaveToFile,
            btnEnabled: hasConsumables,
            icon: MdiIcons.fileExport,
            onPressed: () async {
              await consumableCubit.saveConsumablesData(context);
              // Create file data (this will need to be implemented similar to the original FileCreator)
              final fileData = AppStrings.generateFileData(consumableCubit);
              final fileName = AppStrings.generateFileName();

              final fileService = di.sl<FileService>();
              final result =
                  await fileService.writeDataToFile(fileName, fileData);

              BotToast.showText(
                duration: Duration(
                  seconds: result
                      ? AppNums.durationToastLong
                      : AppNums.durationToastShort,
                ),
                text: result
                    ? AppStrings.fileCreated(context, fileName)
                    : AppStrings.fileNotCreated(context),
                textStyle: const TextStyle(color: Colors.white),
              );
            },
            tooltip: AppStrings.createFileTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keySwitchLangConsumablesScreen,
            icon: MdiIcons.translateVariant,
            onPressed: () => AppLocalizations.of(context)!.isEnLocale
                ? localeCubit.toArabic(context, showToast: true)
                : localeCubit.toEnglish(context, showToast: true),
            tooltip: AppStrings.switchLangTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyResetAllCards,
            btnEnabled: hasConsumables,
            icon: MdiIcons.restore,
            onPressed: () => DialogHelper.showResetAllCardsConfirmationDialog(
                context, consumableCubit),
            tooltip: AppStrings.resetItemsTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyRemoveAllCards,
            btnEnabled: hasConsumables,
            icon: MdiIcons.deleteForever,
            onPressed: () => DialogHelper.showRemoveAllCardsConfirmationDialog(
                context, consumableCubit),
            tooltip: AppStrings.removeItemsTooltip(context),
          ),
        ),
        const Spacer(),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyInfo,
            icon: MdiIcons.oil,
            onPressed: () => Navigator.pushNamed(context, Routes.infoRoute),
            tooltip: AppStrings.infoTooltip(context),
          ),
        ),
      ],
    );
  }
}
