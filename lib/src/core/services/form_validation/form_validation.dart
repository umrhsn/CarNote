import 'package:car_note/src/core/services/form_validation/validation_item.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class FormValidation with ChangeNotifier {
  int currentYear = DateTime.now().year;

  ValidationItem _carType = ValidationItem(null, null);
  ValidationItem _modelYear = ValidationItem(null, null);
  ValidationItem _currentKm = ValidationItem(null, null);

  ValidationItem get carType => _carType;
  ValidationItem get modelYear => _modelYear;
  ValidationItem get currentKm => _currentKm;

  bool get isCarTypeValid => _carType.value != null;
  bool get isModelYearValid => _modelYear.value != null;
  bool get isTravelledDistanceValid => _currentKm.value != null;
  bool get isValid => isCarTypeValid && isModelYearValid && isTravelledDistanceValid;

  void validateCarTypeForm(String? value, BuildContext context) {
    if (value!.isEmpty) {
      _carType = ValidationItem(null, AppStrings.requiredField(context));
    } else {
      _carType = ValidationItem(value, null);
    }

    notifyListeners();
  }

  void validateModelYearForm(String? value, BuildContext context) {
    final bool matchesLength = value!.length >= 4;
    final bool yearValid = int.parse(value) <= currentYear;

    if (value.isEmpty) {
      _modelYear = ValidationItem(null, AppStrings.requiredField(context));
    } else if (!matchesLength) {
      _modelYear = ValidationItem(null, AppStrings.yearMatchesLength(context));
    } else if (!yearValid) {
      _modelYear = ValidationItem(null, AppStrings.yearInvalid(context));
    } else {
      _modelYear = ValidationItem(value, null);
    }

    notifyListeners();
  }

  void validateCurrentKmForm(String? value, BuildContext context) {
    if (value!.isEmpty) {
      _currentKm = ValidationItem(null, AppStrings.requiredField(context));
    } else {
      _currentKm = ValidationItem(value, null);
    }

    notifyListeners();
  }

  void submitData() {
    debugPrint('first name: ${_carType.value}'
        '\nlast name: ${_modelYear.value}'
        '\nusername: ${_currentKm.value}');
  }
}
