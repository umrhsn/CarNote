import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:flutter/services.dart';

// not using it in this app anymore
class TitleCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) =>
      TextEditingValue(text: capitalize(newValue.text), selection: newValue.selection);
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return value.toTitleCase();
}
