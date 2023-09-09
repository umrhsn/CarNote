import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(BuildContext context) => _translate(context, "app_name");

  static const String fontFamilyEn = 'DIN Next'; // Product Sans
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String _translate(BuildContext context, String stringKey) =>
      AppLocalizations.of(context)!.translate(stringKey)!;

  static List<String> _translateList(BuildContext context, String stringKey) =>
      AppLocalizations.of(context)!.translateList(stringKey)!;

  /// Database
  static const String carBox = 'car';
  static const String consumableBox = 'consumable';

  static List<String> get consumables =>
      LocaleCubit.currentLangCode == ar ? consumablesArabicList : consumablesEnglishList;

  static List<String> consumablesEnglishList = [
    'Oil',
    'Oil Filter',
    'Timing Belt',
    'Dynamo Belt',
    'Fuel Filter',
    'Air Filter',
    'AC Filter',
    'AC belt',
    'Gearbox Oil',
    'Antifreeze Coolant',
    'Spark Plugs',
    'Brake Linings'
  ];

  static List<String> consumablesArabicList = [
    'الزيت',
    'فلتر الزيت',
    'سير الكاتينة',
    'سير الدينامو',
    'فلتر البنزين',
    'فلتر الهواء',
    'فلتر التكييف',
    'سير التكييف',
    'زيت الفتيس',
    'مياه التبريد',
    'البوچيهات',
    'تيل الفرامل'
  ];
  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotif = 'notifications_set';
  static const String prefsBoolDetailedModeOn = 'detailed_mode_on';
  static const String prefsBoolEditModeOn = 'edit_mode_on';
  static const String prefsBoolListAdded = 'list_added';
  static const String prefsStringNotifScheduleTime = 'schedule_time';

  /// Buttons
  static String btnContinue(BuildContext context) =>
      _translate(context, "btn_continue").toUpperCase();

  static String btnSave(BuildContext context) => _translate(context, "btn_save").toUpperCase();

  static String btnAddItem(BuildContext context) => _translate(context, "add_item").toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(BuildContext context) =>
      _translate(context, "data_saved_successfully");

  static String somethingWentWrong(BuildContext context) =>
      _translate(context, "something_went_wrong");

  static String detailedModeOn(BuildContext context) => _translate(context, "detailed_mode_on");

  static String detailedModeOff(BuildContext context) => _translate(context, "detailed_mode_off");

  static String notifTimeMsg(BuildContext context) => _translate(context, "notif_time_msg");

  static String getNotifTime(TimeOfDay scheduleTime) => scheduleTime.toString().substring(
      scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) =>
      _translate(context, "daily_notif_off");

  static String notificationTimeNotSet(BuildContext context) =>
      _translate(context, "notif_time_not_set");

  static String tapBackAgainToExit(BuildContext context) =>
      _translate(context, "tap_back_again_to_exit");

  static String langChangedToast(BuildContext context) => _translate(context, "lang_changed_toast");

  static String fileCreated(BuildContext context) =>
      "${_translate(context, "file_named")}\n${FileCreator.fileName}.txt\n${_translate(context, "file_created")}";

  static String fileNotCreated(BuildContext context) => _translate(context, "file_not_created");

  static String nameNotEmpty(BuildContext context) => _translate(context, "name_not_empty");

  static String removedItem(BuildContext context) =>
      _translate(context, "removed_item_successfully");

  static String removedAllData(BuildContext context) => _translate(context, "removed_all_data");

  static String itemAdded(BuildContext context) => _translate(context, "item_added");

  /// Hints
  static String carTypeHint(BuildContext context) => _translate(context, "car_type_hint");

  static String modelYearHint(BuildContext context) => _translate(context, "model_year_hint");

  static String currentKmHint(BuildContext context) => _translate(context, "current_km_hint");

  static String nameHint(BuildContext context) => _translate(context, "name_hint");

  static String currentKmLabel(BuildContext context) => _translate(context, "current_km_label");

  /// Labels
  static String lastChangedAtLabel(BuildContext context) =>
      _translate(context, "last_changed_at_label");

  static String changeIntervalLabel(BuildContext context) =>
      _translate(context, "change_interval_label");

  static String remainingKmNormalWarningLabel(BuildContext context) =>
      _translate(context, "remaining_km_normal_warning_label");

  static String advice(BuildContext context) => _translate(context, "advice");

  static String severity(BuildContext context) => _translate(context, "severity");

  static String remainingKmErrorLabel(BuildContext context) =>
      _translate(context, "remaining_km_error_label");

  /// Validators
  static String requiredField(BuildContext context) => _translate(context, "required_field");

  static String yearMatchesLength(BuildContext context) =>
      _translate(context, "year_matches_length");

  static String yearInvalid(BuildContext context) => _translate(context, "year_invalid");

  static String invalidInput(BuildContext context) => _translate(context, "invalid_input");

  static String normalAndWarningText(BuildContext context) =>
      _translate(context, "normal_warning_text");

  static String considerText(BuildContext context) => _translate(context, "consider_text");

  static String errorText(BuildContext context) => _translate(context, "error_text");

  static String remaining(BuildContext context) => _translate(context, "remaining");

  static String km(BuildContext context) => _translate(context, "km");

  /// Dialogs
  static String changedDataMsg(BuildContext context) => _translate(context, "changed_data_msg");

  static String sureToDeleteMsg(BuildContext context) => _translate(context, "sure_to_delete");

  static String sureToExitMsg(BuildContext context) => _translate(context, "sure_to_exit");

  static String saveData(BuildContext context) => _translate(context, "save_data").toUpperCase();

  static String exitWithoutSaving(BuildContext context) =>
      _translate(context, "exit_without_saving").toUpperCase();

  static String removingItem(BuildContext context, int index) =>
      "${_translate(context, "removing_item")}\n'${DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index].name}'";

  static String removeItem(BuildContext context) => _translate(context, "remove_item");

  static String cancel(BuildContext context) => _translate(context, "cancel");

  static String removeAllDataConfirmationDialogTitle(BuildContext context) =>
      _translate(context, "remove_all_data_confirmation_dialog_title");

  static String removeAllDataConfirmationDialogContent(BuildContext context) =>
      _translate(context, "remove_all_data_confirmation_dialog_content");

  static String proceed(BuildContext context) => _translate(context, "proceed");

  static String removeAllDataAssuringDialogTitle(BuildContext context) =>
      _translate(context, "remove_all_data_assuring_dialog_title");

  static String removeAllDataAssuringDialogContent(BuildContext context) =>
      _translate(context, "remove_all_data_assuring_dialog_content");

  static String eraseData(BuildContext context) => _translate(context, "erase_data");

  /// AppBar titles
  static String addConsumable(BuildContext context) => _translate(context, "add_an_item");

  /// Notifications
  static const String notifChannelBasicGroupKey = 'basic_channel_group';
  static const String notifChannelBasicGroupName = 'Basic group';
  static const String notifChannelScheduledGroupKey = 'scheduled_channel_group';
  static const String notifChannelScheduledGroupName = 'Scheduled group';

  static const String notifChannelBasicKey = 'basic_channel';
  static const String notifChannelBasicName = 'Basic notifications';
  static const String notifChannelBasicDescription = 'Notification channel for basic notifications';
  static const String notifChannelScheduledKey = 'scheduled_channel';
  static const String notifChannelScheduledName = 'Scheduled notifications';
  static const String notifChannelScheduledDescription =
      'Notification channel for scheduled notifications';

  static String dailyNotificationTitle(BuildContext context) =>
      _translate(context, "daily_notif_title");

  static String dailyNotificationBody(BuildContext context) =>
      _translate(context, "daily_notif_body");

  static String dailyNotificationTimePickerHelperText(BuildContext context) =>
      _translate(context, "daily_notif_time_picker_helper_text");

  /// Tooltips
  static String toggleModeTooltip(BuildContext context) =>
      _translate(context, "toggle_mode_tooltip");

  static String switchLangTooltip(BuildContext context) =>
      _translate(context, "switch_language_tooltip");

  static String createFileTooltip(BuildContext context) =>
      _translate(context, "create_file_tooltip");

  static String infoTooltip(BuildContext context) => _translate(context, "info_tooltip");

  static String switchToGridView(BuildContext context) =>
      _translate(context, "switch_to_grid_view");

  static String switchToListView(BuildContext context) =>
      _translate(context, "switch_to_list_view");

  static String switchedToGridView(BuildContext context) =>
      _translate(context, "switched_to_grid_view");

  static String switchedToListView(BuildContext context) =>
      _translate(context, "switched_to_list_view");

  static String sortByAlphaTooltip(BuildContext context) =>
      _translate(context, "sort_by_alpha_tooltip");

  static String sortByCategoryTooltip(BuildContext context) =>
      _translate(context, "sort_by_category_tooltip");

  static String sortBySeverityTooltip(BuildContext context) =>
      _translate(context, "sort_by_severity_tooltip");

  static String eraseDataTooltip(BuildContext context) => _translate(context, "erase_data_tooltip");

  /// Lists
  static List<DashboardItem> dashboardItems(BuildContext context) =>
      List.generate(
        AssetManager.warningSymbols.length,
        (index) => DashboardItem(
          category: 1,
          image: AssetManager.warningSymbols[index],
          title: _warningTitles(context)[index],
          description: _warningDescriptions(context)[index],
          advice: _warningAdvices(context)[index],
          severity: _warningSeverities[index],
        ),
      ) +
      List.generate(
        AssetManager.advisorySymbols.length,
        (index) => DashboardItem(
          category: 2,
          image: AssetManager.advisorySymbols[index],
          title: _advisoryTitles(context)[index],
          description: _advisoryDescriptions(context)[index],
          advice: _advisoryAdvices(context)[index],
          severity: _advisorySeverities[index],
        ),
      ) +
      List.generate(
        AssetManager.infoSymbols.length,
        (index) => DashboardItem(
          category: 3,
          image: AssetManager.infoSymbols[index],
          title: _infoTitles(context)[index],
          description: _infoDescriptions(context)[index],
          advice: _infoAdvices(context)[index],
          severity: _infoSeverities[index],
        ),
      );

  static List<String> _warningTitles(BuildContext context) =>
      _translateList(context, "warning_titles");

  static List<String> _advisoryTitles(BuildContext context) =>
      _translateList(context, "advisory_titles");

  static List<String> _infoTitles(BuildContext context) => _translateList(context, "info_titles");

  static List<String> _warningDescriptions(BuildContext context) =>
      _translateList(context, "warning_descriptions");

  static List<String> _advisoryDescriptions(BuildContext context) =>
      _translateList(context, "advisory_descriptions");

  static List<String> _infoDescriptions(BuildContext context) =>
      _translateList(context, "info_descriptions");

  static List<String> _warningAdvices(BuildContext context) =>
      _translateList(context, "warning_advices");

  static List<String> _advisoryAdvices(BuildContext context) =>
      _translateList(context, "advisory_advices");

  static List<String> _infoAdvices(BuildContext context) => _translateList(context, "info_advices");

  static final List<int> _warningSeverities = [
    9,
    9,
    9,
    8,
    8,
    7,
    4,
    7,
    3,
    8,
    9,
    9,
    9,
    9,
    1,
    1,
    2,
    4,
    9,
    1,
    1,
    7,
    7,
    8,
    9,
    7,
    7,
    9
  ];
  static final List<int> _advisorySeverities = [
    9,
    7,
    9,
    9,
    7,
    1,
    7,
    3,
    8,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    3,
    4,
    6,
    1,
    8,
    3,
    2,
    7,
    4,
    4,
    7,
    2,
    6,
    3,
    8,
    3,
    9,
    1,
    7,
    6,
    4,
    7,
    7,
    7,
    1,
    1,
    1,
    1,
    1,
    7,
    4,
  ];
  static final List<int> _infoSeverities = [
    2,
    2,
    1,
    1,
    1,
    1,
    2,
    1,
    1,
    1,
    2,
    4,
    4,
    4,
    4,
    1,
    1,
    3,
    3,
    1,
    1,
    2,
    2,
    2,
    2,
    1,
    1,
    2,
    1,
    1,
    1,
    2,
    2,
    2,
    3,
    2,
    2,
  ];

  // FIXME: these methods were functional before switching lists to json files
  static void sortAlphabetically(BuildContext context) =>
      dashboardItems(context).sort((a, b) => a.title.compareTo(b.title));

  static void sortCategories(BuildContext context) {
    sortAlphabetically(context);
    dashboardItems(context).sort((a, b) => a.category.compareTo(b.category));
  }

  static void sortSeverities(BuildContext context) {
    sortCategories(context);
    dashboardItems(context).sort((a, b) => b.severity.compareTo(a.severity));
  }

  static String nothingHere(BuildContext context) => _translate(context, "nothing_here");

  static String tryToAddItems(BuildContext context) => _translate(context, "try_to_add_items");

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
