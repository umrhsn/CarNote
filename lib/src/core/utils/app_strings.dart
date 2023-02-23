import 'package:intl/intl.dart';

class AppStrings {
  static String carBox = 'car';
  static String consumableBox = 'consumable';

  static String fontFamily = 'Product Sans';

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

  static String methodName(Function method) {
    return method
        .toString()
        .substring(method.toString().indexOf("'") + 1, method.toString().lastIndexOf("'"));
  }

  static const String requiredField = '*required field';
  static const String yearMatchesLength = '*year should be 4 digits at least';
  static const String yearNotValid = '*invalid year';

  static const String warningText = 'remaining. You need to change this item soon.';
  static const String errorText = 'Exceeded by';

  static const String km = 'km';
}
