import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';

class AppStrings {
  static String _translate(BuildContext context, String stringKey) =>
      AppLocalizations.of(context)!.translate(stringKey)!;

  static String appName(BuildContext context) => _translate(context, "app_name");

  static const String carBox = 'car';
  static const String consumableBox = 'consumable';

  static const String fontFamilyProductSans = 'Product Sans';
  static const String fontFamilyCursedTimer = 'CursedTimer';

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

  static List<String> consumables = [
    'Oil & Oil Filter', // الزيت وفلتر الزيت
    'Timing Belt', // سير الموتور
    'Dynamo Belt', // سير الدينامو
    'Fuel Filter', // فلتر البنزين
    'Air Filter', // فلتر الهواء
    'AC Filter', // فلتر التكييف
    'AC belt', // سير التكييف
    'Gearbox Oil', // زيت الفتيس
    'Antifreeze Coolant', // مية التبريد
    'Spark Plugs', // البوجيهات
    'Brake Linings' // تيل الفرامل
  ];

  static String currentKmLabel(BuildContext context) => _translate(context, "current_km_label");
  static String lastChangedAtLabel(BuildContext context) => _translate(context, "last_changed_at_label");
  static String changeIntervalLabel(BuildContext context) => _translate(context, "change_interval_label");
  static String changeKmLabel(BuildContext context) => _translate(context, "change_km_label");

  static String getMethodName(Function method) {
    return method
        .toString()
        .substring(method.toString().indexOf("'") + 1, method.toString().lastIndexOf("'"));
  }

  static  String requiredField(BuildContext context) => _translate(context, "required_field");
  static  String yearMatchesLength(BuildContext context) => _translate(context, "year_matches_length");
  static  String yearInvalid(BuildContext context) => _translate(context, "year_invalid");
  static  String invalidInput(BuildContext context) => _translate(context, "invalid_input");

  static String warningText(BuildContext context) => _translate(context, "warning_text");
  static String errorText(BuildContext context) => _translate(context, "error_text");
  static String remaining(BuildContext context) => _translate(context, "remaining");

  static String km(BuildContext context) => _translate(context, "km");

  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotif = 'notifications_set';
  static const String prefsBoolVisible = 'visible';
  static const String prefsStringNotifScheduleTime = 'schedule_time';

  static String changedDataMsg(BuildContext context) => _translate(context, "changed_data_msg");
  static String sureToExitMsg(BuildContext context) => _translate(context, "sure_to_exit");

  static String saveData(BuildContext context) => _translate(context, "save_data").toUpperCase();
  static String exitWithoutSaving(BuildContext context) => _translate(context, "exit_without_saving").toUpperCase();

  static String tapBackAgainToExit(BuildContext context) => _translate(context, "tap_back_again_to_exit");

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

  static String dailyNotificationTitle(BuildContext context) => _translate(context, "daily_notif_title");
  static String dailyNotificationBody(BuildContext context) => _translate(context, "daily_notif_body");
  static String dailyNotificationTimePickerHelperText(BuildContext context) => _translate(context, "daily_notif_time_picker_helper_text");

  static String detailedModeOn(BuildContext context) => _translate(context, "detailed_mode_on");
  static String detailedModeOff(BuildContext context) => _translate(context, "detailed_mode_off");

  static String notifTimeMsg(BuildContext context) => _translate(context, "notif_time_msg");

  static String getNotifTime(TimeOfDay scheduleTime) => scheduleTime.toString().substring(
      scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static String dailyNotificationOff(BuildContext context) => _translate(context, "daily_notif_off");

  static String notificationTimeNotSet(BuildContext context) => _translate(context, "notif_time_not_set");

  /// error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';

  /// localization
  static const String locale = 'locale';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
}
