import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';

class AppStrings {
  static String _translate(BuildContext context, String stringKey) =>
      AppLocalizations.of(context)!.translate(stringKey)!;

  static String appName(BuildContext context) => _translate(context, "app_name");

  static const String _fontFamilyEn = 'Product Sans';
  static const String _fontFamilyAr = 'ArabicTwo';

  static String get fontFamily => LocaleCubit.currentLangCode == en ? _fontFamilyEn : _fontFamilyAr;

  static const String carBox = 'car';
  static const String consumableBox = 'consumable';

  static String btnContinue(BuildContext context) =>
      _translate(context, "btn_continue").toUpperCase();

  static String btnSave(BuildContext context) => _translate(context, "btn_save").toUpperCase();

  static String dataAddedSuccessfully(BuildContext context) =>
      _translate(context, "data_added_successfully");

  static String somethingWentWrong(BuildContext context) =>
      _translate(context, "something_went_wrong");

  static String carTypeHint(BuildContext context) => _translate(context, "car_type_hint");

  static String modelYearHint(BuildContext context) => _translate(context, "model_year_hint");

  static String currentKmHint(BuildContext context) => _translate(context, "current_km_hint");

  static String nameHint(BuildContext context) => _translate(context, "name_hint");

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

  static String currentKmLabel(BuildContext context) => _translate(context, "current_km_label");

  static String lastChangedAtLabel(BuildContext context) =>
      _translate(context, "last_changed_at_label");

  static String changeIntervalLabel(BuildContext context) =>
      _translate(context, "change_interval_label");

  static String remainingKmNormalWarningLabel(BuildContext context) =>
      _translate(context, "remaining_km_normal_warning_label");

  static String remainingKmErrorLabel(BuildContext context) =>
      _translate(context, "remaining_km_error_label");

  static String requiredField(BuildContext context) => _translate(context, "required_field");

  static String yearMatchesLength(BuildContext context) =>
      _translate(context, "year_matches_length");

  static String yearInvalid(BuildContext context) => _translate(context, "year_invalid");

  static String invalidInput(BuildContext context) => _translate(context, "invalid_input");

  static String normalAndWarningText(BuildContext context) =>
      _translate(context, "normal_warning_text");

  static String errorText(BuildContext context) => _translate(context, "error_text");

  static String remaining(BuildContext context) => _translate(context, "remaining");

  static String km(BuildContext context) => _translate(context, "km");

  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotif = 'notifications_set';
  static const String prefsBoolVisible = 'visible';
  static const String prefsBoolListAdded = 'list_added';
  static const String prefsStringNotifScheduleTime = 'schedule_time';

  static String changedDataMsg(BuildContext context) => _translate(context, "changed_data_msg");

  static String sureToExitMsg(BuildContext context) => _translate(context, "sure_to_exit");

  static String saveData(BuildContext context) => _translate(context, "save_data").toUpperCase();
  static String addConsumable(BuildContext context) => _translate(context, "add_item");

  static String exitWithoutSaving(BuildContext context) =>
      _translate(context, "exit_without_saving").toUpperCase();

  static String tapBackAgainToExit(BuildContext context) =>
      _translate(context, "tap_back_again_to_exit");

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

  static String detailedModeOn(BuildContext context) => _translate(context, "detailed_mode_on");

  static String detailedModeOff(BuildContext context) => _translate(context, "detailed_mode_off");

  static String notifTimeMsg(BuildContext context) => _translate(context, "notif_time_msg");

  static String getNotifTime(TimeOfDay scheduleTime) => scheduleTime.toString().substring(
      scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) =>
      _translate(context, "daily_notif_off");

  static String notificationTimeNotSet(BuildContext context) =>
      _translate(context, "notif_time_not_set");

  /// error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';

  /// localization
  static const String locale = 'locale';
  static const String en = 'en';
  static const String ar = 'ar';

  static String langChangedToast(BuildContext context) => _translate(context, "lang_changed_toast");

  static String fileCreated(BuildContext context) => _translate(context, "file_created");

  static String fileNotCreated(BuildContext context) => _translate(context, "file_not_created");
}
