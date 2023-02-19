class AppStrings {
  static String databaseName = 'car_note.db';
  static String consumablesTable = 'Consumables';
  static String consumablesTableCol1 = 'name';
  static String consumablesTableCol2 = 'last_changed_at';
  static String consumablesTableCol3 = 'change_interval';
  static String consumablesTableCol4 = 'to_be_changed_at';

  static String fontFamily = 'Product Sans';

  static const String btnContinue = 'Continue';
  static const String btnSave = 'Save';

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
}
