import 'dart:ui';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:car_note/injection_container.dart' as di;

class AppTourService {
  static late TutorialCoachMark _tutorialCoachMark;

  static void showTutorial(BuildContext context) => _tutorialCoachMark.show(context: context);

  static bool shouldBeginTour({required String prefsBoolKey}) {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    if (prefs.getBool(prefsBoolKey) == null) prefs.setBool(prefsBoolKey, true);
    bool showTutorial = prefs.getBool(prefsBoolKey) ?? true;
    return showTutorial;
  }

  static beginCarInfoScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createCarInfoScreenTour(context);
      Future.delayed(const Duration(seconds: AppNums.durationTutorialDelay), () => AppTourService.showTutorial(context));
    });
  }

  static beginConsumablesScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createConsumablesScreenTour(context);
      Future.delayed(const Duration(seconds: AppNums.durationTutorialDelay), () => AppTourService.showTutorial(context));
    });
  }

  static beginDashboardScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createDashboardScreenTour(context);
      Future.delayed(const Duration(seconds: AppNums.durationTutorialDelay), () => AppTourService.showTutorial(context));
    });
  }

  static void _createCarInfoScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createCarInfoScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: AppDimens.padding10,
      opacityShadow: AppNums.tutorialOpacityShadow,
      imageFilter: ImageFilter.blur(sigmaX: AppNums.tutorialImageFilterSigmaX, sigmaY: AppNums.tutorialImageFilterSigmaY),
    );
    di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolBeginCarInfoScreenTour, false);
  }

  static void _createConsumablesScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createConsumablesScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: AppDimens.padding10,
      opacityShadow: AppNums.tutorialOpacityShadow,
      imageFilter: ImageFilter.blur(sigmaX: AppNums.tutorialImageFilterSigmaX, sigmaY: AppNums.tutorialImageFilterSigmaY),
    );
    di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolBeginConsumablesScreenTour, false);
  }

  static void _createDashboardScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createDashboardScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: AppDimens.padding10,
      opacityShadow: AppNums.tutorialOpacityShadow,
      imageFilter: ImageFilter.blur(sigmaX: AppNums.tutorialImageFilterSigmaX, sigmaY: AppNums.tutorialImageFilterSigmaY),
    );
    di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolBeginDashboardScreenTour, false);
  }

  static List<TargetFocus> _createCarInfoScreenTargets(BuildContext context) {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: AppKeys.key_switch_lang,
        keyTarget: AppKeys.keySwitchLangCarInfoScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    return targets;
  }

  static List<TargetFocus> _createConsumablesScreenTargets(BuildContext context) {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: AppKeys.key_app_bar_text_field,
        keyTarget: AppKeys.keyAppBarTextField,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetAppBarTextField(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_list,
        keyTarget: AppKeys.keyList,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Text(
              AppStrings.tourTargetList(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_card,
        keyTarget: AppKeys.keyCard,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetCard(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_text_field_last_changed,
        keyTarget: AppKeys.keyTextFieldLastChanged,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetTextFieldLastChanged(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_text_field_change_interval,
        keyTarget: AppKeys.keyTextFieldChangeInterval,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetTextFieldChangeInterval(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_text_field_remaining,
        keyTarget: AppKeys.keyTextFieldRemaining,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetTextFieldRemaining(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_edit_name,
        keyTarget: AppKeys.keyEditName,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetEditName(context),
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_reset_card,
        keyTarget: AppKeys.keyResetCard,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetResetItem(context),
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );    targets.add(
      TargetFocus(
        identify: AppKeys.key_remove_card,
        keyTarget: AppKeys.keyRemoveCard,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetRemoveItem(context),
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_card_reorder,
        keyTarget: AppKeys.keyCard,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetCardReorder(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_save_data,
        keyTarget: AppKeys.keySaveData,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Text(
              AppStrings.tourTargetSaveData(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_add_item,
        keyTarget: AppKeys.keyAddItem,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) => Text(
              AppStrings.tourTargetAddItem(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_toggle_detailed_mode,
        keyTarget: AppKeys.keyToggleDetailedMode,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetToggleDetailedMode(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_save_to_file,
        keyTarget: AppKeys.keySaveToFile,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSaveToFile(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_reset_all_cards,
        keyTarget: AppKeys.keyResetAllCards,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetResetAllCards(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_remove_all_cards,
        keyTarget: AppKeys.keyRemoveAllCards,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetRemoveAllCards(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_info,
        keyTarget: AppKeys.keyInfo,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetInfo(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_switch_lang,
        keyTarget: AppKeys.keySwitchLangConsumablesScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    return targets;
  }

  static List<TargetFocus> _createDashboardScreenTargets(BuildContext context) {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: AppKeys.key_grid_item,
        keyTarget: AppKeys.keyGridItem,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(
              AppStrings.tourTargetGridItem(context),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
        shape: ShapeLightFocus.RRect,
        radius: 10,
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_switch_list_grid,
        keyTarget: AppKeys.keySwitchListGrid,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchListGrid(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: AppKeys.key_switch_lang,
        keyTarget: AppKeys.keySwitchLangDashboardScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    return targets;
  }
}
