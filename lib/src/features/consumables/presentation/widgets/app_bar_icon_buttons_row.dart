import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/custom_icon_button.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    if (_prefs.getBool(AppStrings.prefsBoolDetailedModeOn) == null) {
      _prefs.setBool(AppStrings.prefsBoolDetailedModeOn, true);
    }
    bool visible = _prefs.getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;
    return visible;
  }

  @override
  Widget build(BuildContext context) {
    List? list = DatabaseHelper.consumableBox.get(AppStrings.consumableBox);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          key: AppTourService.keySwitchLangConsumalbesScreen,
          icon: const FaIcon(FontAwesomeIcons.language),
          onPressed: () => AppLocalizations.of(context)!.isEnLocale
              ? localeCubit.toArabic(context)
              : localeCubit.toEnglish(context),
          tooltip: AppStrings.switchLangTooltip(context),
        ),
        const Spacer(),
        CustomIconButton(
          key: AppTourService.keyToggleDetailedMode,
          btnEnabled: list!.isNotEmpty,
          icon: _getVisibilityStatus() ? Icons.visibility : Icons.visibility_outlined,
          onPressed: () => consumableCubit.changeVisibility(context),
          tooltip: AppStrings.toggleModeTooltip(context),
        ),
        CustomIconButton(
          key: AppTourService.keySaveToFile,
          btnEnabled: list.isNotEmpty,
          icon: Icons.file_copy,
          onPressed: () => DatabaseHelper.writeConsumablesData(context).then((value) =>
              FileCreator.writeDataToFile().then((value) => BotToast.showText(
                  duration: Duration(seconds: value == true ? 7 : 2),
                  text: value == true
                      ? AppStrings.fileCreated(context)
                      : AppStrings.fileNotCreated(context),
                  textStyle: const TextStyle(color: Colors.white)))),
          tooltip: AppStrings.createFileTooltip(context),
        ),
        CustomIconButton(
          key: AppTourService.keyDeleteAll,
          btnEnabled: list.isNotEmpty,
          icon: Icons.delete_forever,
          onPressed: () => DialogHelper.showRemoveAllDataConfirmationDialog(context),
          tooltip: AppStrings.eraseDataTooltip(context),
        ),
        const Spacer(),
        IconButton(
          key: AppTourService.keyInfo,
          onPressed: () => Navigator.pushNamed(context, Routes.infoRoute),
          icon: const Icon(Icons.info),
          tooltip: AppStrings.infoTooltip(context),
        ),
      ],
    );
  }
}
