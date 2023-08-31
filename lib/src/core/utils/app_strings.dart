import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/file_creator/file_creator.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  /// Core
  static String appName(context) => _translate(context, "app_name");

  static const String fontFamilyEn = 'Product Sans';
  static const String fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? fontFamilyEn : fontFamilyAr;

  /// Localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String _translate(context, String stringKey) =>
      AppLocalizations.of(context)!.translate(stringKey)!;

  static String? _translateNullable(context, String stringKey) =>
      AppLocalizations.of(context)!.translate(stringKey);

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
  static String btnContinue(context) => _translate(context, "btn_continue").toUpperCase();

  static String btnSave(context) => _translate(context, "btn_save").toUpperCase();

  static String btnAddItem(context) => _translate(context, "add_item").toUpperCase();

  /// Toasts
  static String dataSavedSuccessfully(context) => _translate(context, "data_saved_successfully");

  static String somethingWentWrong(context) => _translate(context, "something_went_wrong");

  static String detailedModeOn(context) => _translate(context, "detailed_mode_on");

  static String detailedModeOff(context) => _translate(context, "detailed_mode_off");

  static String notifTimeMsg(context) => _translate(context, "notif_time_msg");

  static String getNotifTime(TimeOfDay scheduleTime) => scheduleTime.toString().substring(
      scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(context) => _translate(context, "daily_notif_off");

  static String notificationTimeNotSet(context) => _translate(context, "notif_time_not_set");

  static String tapBackAgainToExit(context) => _translate(context, "tap_back_again_to_exit");

  static String langChangedToast(context) => _translate(context, "lang_changed_toast");

  static String fileCreated(context) =>
      "${_translate(context, "file_named")}\n${FileCreator.fileName}.txt\n${_translate(context, "file_created")}";

  static String fileNotCreated(context) => _translate(context, "file_not_created");

  static String nameNotEmpty(context) => _translate(context, "name_not_empty");

  static String removedItem(context) => _translate(context, "removed_item_successfully");

  static String itemAdded(context) => _translate(context, "item_added");

  /// Hints
  static String carTypeHint(context) => _translate(context, "car_type_hint");

  static String modelYearHint(context) => _translate(context, "model_year_hint");

  static String currentKmHint(context) => _translate(context, "current_km_hint");

  static String nameHint(context) => _translate(context, "name_hint");

  static String currentKmLabel(context) => _translate(context, "current_km_label");

  /// Labels
  static String lastChangedAtLabel(context) => _translate(context, "last_changed_at_label");

  static String changeIntervalLabel(context) => _translate(context, "change_interval_label");

  static String remainingKmNormalWarningLabel(context) =>
      _translate(context, "remaining_km_normal_warning_label");

  static String advice(context) => _translate(context, "advice");

  static String severity(context) => _translate(context, "severity");

  static String remainingKmErrorLabel(context) => _translate(context, "remaining_km_error_label");

  /// Validators
  static String requiredField(context) => _translate(context, "required_field");

  static String yearMatchesLength(context) => _translate(context, "year_matches_length");

  static String yearInvalid(context) => _translate(context, "year_invalid");

  static String invalidInput(context) => _translate(context, "invalid_input");

  static String normalAndWarningText(context) => _translate(context, "normal_warning_text");

  static String errorText(context) => _translate(context, "error_text");

  static String remaining(context) => _translate(context, "remaining");

  static String km(context) => _translate(context, "km");

  /// Dialogs
  static String changedDataMsg(context) => _translate(context, "changed_data_msg");

  static String sureToDeleteMsg(context) => _translate(context, "sure_to_delete");

  static String sureToExitMsg(context) => _translate(context, "sure_to_exit");

  static String saveData(context) => _translate(context, "save_data").toUpperCase();

  static String exitWithoutSaving(context) =>
      _translate(context, "exit_without_saving").toUpperCase();

  static String removingItem(context, int index) =>
      "${_translate(context, "removing_item")}\n'${DatabaseHelper.consumableBox.get(AppStrings.consumableBox)![index].name}'";

  static String removeItem(context) => _translate(context, "remove_item");

  static String cancel(context) => _translate(context, "cancel");

  /// AppBar titles
  static String addConsumable(context) => _translate(context, "add_an_item");

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

  static String dailyNotificationTitle(context) => _translate(context, "daily_notif_title");

  static String dailyNotificationBody(context) => _translate(context, "daily_notif_body");

  static String dailyNotificationTimePickerHelperText(context) =>
      _translate(context, "daily_notif_time_picker_helper_text");

  /// Tooltips
  static String toggleModeTooltip(context) => _translate(context, "toggle_mode_tooltip");

  static String switchLangTooltip(context) => _translate(context, "switch_language_tooltip");

  static String createFileTooltip(context) => _translate(context, "create_file_tooltip");

  static String infoTooltip(context) => _translate(context, "info_tooltip");

  static String switchToGridView(context) => _translate(context, "switch_to_grid_view");

  static String switchToListView(context) => _translate(context, "switch_to_list_view");

  static String sortByAlphaTooltip(context) => _translate(context, "sort_by_alpha_tooltip");

  static String sortByCategoryTooltip(context) => _translate(context, "sort_by_category_tooltip");

  static String sortBySeverityTooltip(context) => _translate(context, "sort_by_severity_tooltip");

  /// Lists
  static List<String?> warningTitles(context) {
    List<String?> list = [];
    for (int index = 0; index < 25; index++) {
      String? item = _translateNullable(context, "warning_titles"[index]);
      debugPrint(item);
      list.add(item);
    }
    return list;
  }

  /// Error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
}
