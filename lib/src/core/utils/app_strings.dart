import 'package:intl/intl.dart';

class AppStrings {
  static const String appName = 'Car Note';

  static const String carBox = 'car';
  static const String consumableBox = 'consumable';

  static const String fontFamily = 'Product Sans';

  static const String btnContinue = 'Continue';
  static const String btnSave = 'Save';

  static const String dataAddedSuccessfully = 'Data added successfully';
  static const String somethingWentWrong = 'Something went wrong';

  static const String carTypeHint = 'Car type. e.g. "Suzuki Maruti"';
  static const String modelYearHint = 'Model year. e.g. "2014"';
  static String currentKmHint =
      'Total distance travelled. e.g. ${NumberFormat.decimalPattern().format(100000)} km';

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
  static const String yearNotValid = '*invalid year';

  static const String warningText = 'remaining. You need to change this item soon.';
  static const String errorText = 'Exceeded by';
  static const String remaining = 'remaining';

  static const String km = 'km';

  static const String prefsBoolSeen = 'seen';
  static const String prefsBoolNotification = 'notifications_set';

  static const String invalidInput = 'invalid input';

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
  static const String notifChannelScheduledDescription = 'Notification channel for scheduled notifications';

  static const String dailyNotificationTitle = "Don't forget to update your data";
  static const String dailyNotificationBody = 'Have you entered your current kilometer for today?';
  static const String dailyNotificationTimePickerHelperText = 'Schedule a daily notification to remind you of updating your data';
}
