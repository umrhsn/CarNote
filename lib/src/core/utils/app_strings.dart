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

  static String btnSave(BuildContext context) => _translate(context, "btn_continue").toUpperCase();

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

  static const String currentKmLabel = 'Current kilometer';
  static const String lastChangedAtLabel = 'Last changed at';
  static const String changeIntervalLabel = 'Change interval';
  static const String changeKmLabel = 'To be changed at';

  static String getMethodName(Function method) {
    return method
        .toString()
        .substring(method.toString().indexOf("'") + 1, method.toString().lastIndexOf("'"));
  }

  static const String requiredField = '*required field';
  static const String yearMatchesLength = '*year should be 4 digits at least';
  static const String yearInvalid = '*invalid year';
  static const String invalidInput = '*invalid input';

  static const String warningText = 'remaining. You need to change this item soon.';
  static const String errorText = 'Exceeded by';
  static const String remaining = 'remaining';

  static String km(BuildContext context) => _translate(context, "km");

  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotif = 'notifications_set';
  static const String prefsBoolVisible = 'visible';
  static const String prefsStringNotifScheduleTime = 'schedule_time';

  static const String changedDataMsg = "You've changed some data.";
  static const String sureToExitMsg = 'Are you sure you want to exit the app without saving?';

  static const String saveData = 'Save data';
  static const String exitWithoutSaving = 'Exit without saving';

  static const String tapBackAgainToExit = 'Tap back again to exit';

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

  static const String dailyNotificationTitle = "Don't forget to update your data";
  static const String dailyNotificationBody = 'Have you entered your current kilometer for today?';
  static const String dailyNotificationTimePickerHelperText =
      'Schedule a daily notification to remind you of updating your data';

  static const String detailedModeOn = 'Detailed mode on';
  static const String detailedModeOff = 'Detailed mode off';

  static const String notifTimeMsg = 'Daily notification on.\n'
      'A daily reminder notification is set to be shown every day at';

  static String getNotifTime(TimeOfDay scheduleTime) => scheduleTime.toString().substring(
      scheduleTime.toString().indexOf('(') + 1, scheduleTime.toString().lastIndexOf(')'));

  static const String dailyNotificationOff = 'Daily notification off';

  static const String notificationTimeNotSet =
      "You didn't set a time for the daily notification.\nNo notification will appear.";

  /// error handling
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';

  /// localization
  static const String locale = 'locale';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
}
