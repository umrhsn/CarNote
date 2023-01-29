class AppStrings {
  static String? fontFamily = 'Product Sans';

  static const String btnContinue = 'Continue';
  static const String btnSave = 'Save';

  static const String consumable1 = 'Oil & Oil Filter'; // الزيت وفلتر الزيت
  static const String consumable2 = 'Serpentine / Drive Belts'; // cambelt? // سير الموتور
  static const String consumable3 = 'Air Filter'; // فلتر الهواء
  static const String consumable4 = 'AC Filter'; // فلتر التكييف
  static const String consumable5 = 'AC belt'; // تيل الفرامل
  static const String consumable6 = 'Gear Lever Oil'; // زيت الفتيس
  static const String consumable7 = 'Antifreeze Coolant'; // مية التبريد
  static const String consumable8 = 'Spark Plugs'; // البوجيهات
  static const String consumable9 = 'Brake Linings'; // تيل الفرامل

  static const String currentKmHint = 'Current kilometer. For example: "100,000"';
  static const String changeIntervalHint = 'Change interval';
  static const String changeKmHint = 'To be changed at..';

  static String methodName(Function method) {
    return method
        .toString()
        .substring(method.toString().indexOf("'") + 1, method.toString().lastIndexOf("'"));
  }

  static const String requiredField = '*required field';
  static const String yearMatchesLength = '*year should be 4 digits at least';
  static const String yearNotValid = '*invalid year';
}
