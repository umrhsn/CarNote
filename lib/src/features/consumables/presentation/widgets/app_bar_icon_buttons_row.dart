import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
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
    List? list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox);

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
            btnEnabled: list!.isNotEmpty,
            icon: _getVisibilityStatus() ? MdiIcons.eye : MdiIcons.eyeOutline,
            onPressed: () => consumableCubit.changeVisibility(context),
            tooltip: AppStrings.toggleModeTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keySaveToFile,
            btnEnabled: list.isNotEmpty,
            icon: MdiIcons.fileExport,
            onPressed: () => DatabaseHelper.writeConsumablesData(context).then(
                (value) => di.sl<FileCreator>().writeDataToFile().then((value) =>
                    BotToast.showText(
                        duration: Duration(
                            seconds: value == true
                                ? AppNums.durationToastLong
                                : AppNums.durationToastShort),
                        text: value == true
                            ? AppStrings.fileCreated(context)
                            : AppStrings.fileNotCreated(context),
                        textStyle: const TextStyle(color: Colors.white)))),
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
            btnEnabled: list.isNotEmpty,
            icon: MdiIcons.restore,
            onPressed: () =>
                DialogHelper.showResetAllCardsConfirmationDialog(context),
            tooltip: AppStrings.resetItemsTooltip(context),
          ),
        ),
        Expanded(
          child: AnimatedIconButton(
            key: AppKeys.keyRemoveAllCards,
            btnEnabled: list.isNotEmpty,
            icon: MdiIcons.deleteForever,
            onPressed: () =>
                DialogHelper.showRemoveAllCardsConfirmationDialog(context),
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
