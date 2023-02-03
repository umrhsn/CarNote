class AppStrings {
  static String? fontFamily = 'Product Sans';

  static const String btnContinue = 'Continue';
  static const String btnSave = 'Save';

  static List consumables = [
    'Oil & Oil Filter', // الزيت وفلتر الزيت
    'Serpentine / Drive Belts', // cambelt? // سير الموتور
    'Air Filter', // فلتر الهواء
    'AC Filter', // فلتر التكييف
    'AC belt', // تيل الفرامل
    'Gear Lever Oil', // زيت الفتيس
    'Antifreeze Coolant', // مية التبريد
    'Spark Plugs', // البوجيهات
    'Brake Linings' // تيل الفرامل
  ];

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
}
