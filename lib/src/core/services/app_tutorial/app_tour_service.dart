import 'dart:ui';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:car_note/injection_container.dart' as di;

class AppTourService {
  static late TutorialCoachMark _tutorialCoachMark;

  static void showTutorial(BuildContext context) => _tutorialCoachMark.show(context: context);

  /// CarInfo
  static final GlobalKey keySwitchLangCarInfoScreen = GlobalKey();

  /// ConsumablesScreen
  static final GlobalKey keyAppBarTextField = GlobalKey();
  static final GlobalKey keyList = GlobalKey();
  static final GlobalKey keyCard = GlobalKey();
  static final GlobalKey keyEditName = GlobalKey();
  static final GlobalKey keyTextFieldLastChanged = GlobalKey();
  static final GlobalKey keyTextFieldChangeInterval = GlobalKey();
  static final GlobalKey keyTextFieldRemaining = GlobalKey();
  static final GlobalKey keyDeleteCard = GlobalKey();
  static final GlobalKey keySaveData = GlobalKey();
  static final GlobalKey keyAddItem = GlobalKey();
  static final GlobalKey keySwitchLangConsumalbesScreen = GlobalKey();
  static final GlobalKey keyToggleDetailedMode = GlobalKey();
  static final GlobalKey keySaveToFile = GlobalKey();
  static final GlobalKey keyDeleteAll = GlobalKey();
  static final GlobalKey keyInfo = GlobalKey();

  /// DashboardScreen
  static final GlobalKey keyGridItem = GlobalKey();
  static final GlobalKey keySwitchListGrid = GlobalKey();
  static final GlobalKey keySwitchLangDashboardScreen = GlobalKey();

  static bool shouldBeginTour({required String prefsBoolKey}) {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    if (prefs.getBool(prefsBoolKey) == null) prefs.setBool(prefsBoolKey, true);
    bool showTutorial = prefs.getBool(prefsBoolKey) ?? true;
    return showTutorial;
  }

  static beginCarInfoScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createCarInfoScreenTour(context);
      Future.delayed(const Duration(seconds: 1), () => AppTourService.showTutorial(context));
    });
  }

  static beginConsumablesScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createConsumablesScreenTour(context);
      Future.delayed(const Duration(seconds: 1), () => AppTourService.showTutorial(context));
    });
  }

  static beginDashboardScreenTour(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppTourService._createDashboardScreenTour(context);
      Future.delayed(const Duration(seconds: 1), () => AppTourService.showTutorial(context));
    });
  }

  static void _createCarInfoScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createCarInfoScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
    di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolBeginCarInfoScreenTour, false);
  }

  static void _createConsumablesScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createConsumablesScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
    di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolBeginConsumablesScreenTour, false);
  }

  static void _createDashboardScreenTour(BuildContext context) {
    _tutorialCoachMark = TutorialCoachMark(
      targets: _createDashboardScreenTargets(context),
      colorShadow: AppColors.getPrimaryColor(context),
      textSkip: AppStrings.skip(context).toUpperCase(),
      textStyleSkip: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
    );
    di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolBeginDashboardScreenTour, false);
  }

  static List<TargetFocus> _createCarInfoScreenTargets(BuildContext context) {
    List<TargetFocus> targets = [];

    targets.add(
      TargetFocus(
        identify: "key_switch_lang",
        keyTarget: keySwitchLangCarInfoScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context),
                style: const TextStyle(color: Colors.white)),
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
        identify: "key_app_bar_text_field",
        keyTarget: keyAppBarTextField,
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
        identify: "key_list",
        keyTarget: keyList,
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
        identify: "key_card",
        keyTarget: keyCard,
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
        identify: "key_text_field_last_changed",
        keyTarget: keyTextFieldLastChanged,
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
        identify: "key_text_field_change_interval",
        keyTarget: keyTextFieldChangeInterval,
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
        identify: "key_text_field_remaining",
        keyTarget: keyTextFieldRemaining,
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
        identify: "key_edit_name",
        keyTarget: keyEditName,
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
        identify: "key_delete_card",
        keyTarget: keyDeleteCard,
        alignSkip: AlignmentDirectional.topEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetDeleteCard(context),
                style: const TextStyle(
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_card_reorder",
        keyTarget: keyCard,
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
        identify: "key_save_data",
        keyTarget: keySaveData,
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
        identify: "key_add_item",
        keyTarget: keyAddItem,
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
        identify: "key_toggle_detailed_mode",
        keyTarget: keyToggleDetailedMode,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetToggleDetailedMode(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_save_to_file",
        keyTarget: keySaveToFile,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSaveToFile(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_delete_all",
        keyTarget: keyDeleteAll,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetDeleteAll(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_info",
        keyTarget: keyInfo,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetInfo(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_switch_lang",
        keyTarget: keySwitchLangConsumalbesScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context),
                style: const TextStyle(color: Colors.white)),
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
        identify: "key_grid_item",
        keyTarget: keyGridItem,
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
        identify: "key_switch_list_grid",
        keyTarget: keySwitchListGrid,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchListGrid(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "key_switch_lang",
        keyTarget: keySwitchLangDashboardScreen,
        alignSkip: AlignmentDirectional.bottomEnd,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Text(AppStrings.tourTargetSwitchLang(context),
                style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    return targets;
  }
}
