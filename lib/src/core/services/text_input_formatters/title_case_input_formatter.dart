import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:flutter/services.dart';

class TitleCaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: capitalize(newValue.text), selection: newValue.selection);
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return value.toTitleCase();
}
