import 'dart:async';

import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/data/models/consumable_model.dart';
import 'package:car_note/src/features/car_info/data/repositories/consumable_repository.dart';
import 'package:car_note/src/features/car_info/domain/entities/consumable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    for (int i = 0; i < Consumable.getCount(); i++) {
      lastChangedAtControllers.add(TextEditingController());
      changeIntervalControllers.add(TextEditingController());
      changeKmControllers.add(TextEditingController());
      lastChangedAtFocuses.add(FocusNode());
      changeIntervalFocuses.add(FocusNode());
      changeKmFocuses.add(FocusNode());
    }
  }

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  final TextEditingController currentKmController = TextEditingController();

  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> changeKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> changeKmFocuses = [];

  bool shouldEnableSaveButton(BuildContext context) {
    for (int i = 0; i < lastChangedAtControllers.length; i++) {
      if (getLastChangedKmErrorText(context, i).data != '') {
        return false;
      }
    }
    return true;
  }

  Text getLastChangedKmErrorText(BuildContext context, int index) {
    return Text(
      validateLastChangedKilometer(index) ?? '',
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        height: validateLastChangedKilometer(index) != null ? 2 : 0,
        fontSize: 11,
      ),
    );
  }

  Text getChangeKmErrorText(BuildContext context, int index) {
    return Text(
      validateChangeKilometer(index) ?? '',
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        height: validateChangeKilometer(index) != null ? 2 : 0,
        fontSize: 11,
      ),
    );
  }

  int _sumChangeKilometer(TextEditingController lastChangedAtKmController,
      TextEditingController changeIntervalController) {
    if (lastChangedAtKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      return int.parse(lastChangedAtKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
    }
    return 0;
  }

  void getChangeKilometer(int index) {
    emit(AddingChangeKm());
    changeKmControllers[index].text =
        _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index])
                .toThousands()
            : '';
    emit(AddedChangeKm());
  }

  void validateAllLastChangedKilometerFields() {
    emit(ValidatingItem());
    for (int i = 0; i < changeKmControllers.length; i++) {
      validateLastChangedKilometer(i);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields() {
    emit(ValidatingItem());
    for (int i = 0; i < changeKmControllers.length; i++) {
      validateChangeKilometer(i);
    }
    emit(ValidatingComplete());
  }

  getErrorText(int index) {
    return validateLastChangedKilometer(index);
  }

  // last changed kilometer should not exceed current kilometer
  String? validateLastChangedKilometer(int index) {
    emit(ValidatingItem());
    if (lastChangedAtControllers[index].text.isNotEmpty && currentKmController.text.isNotEmpty) {
      if (int.parse(lastChangedAtControllers[index].text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return "invalid input";
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  int calculateChangeKmAndCurrentKmDifference(int index) {
    if (currentKmController.text.isNotEmpty && changeKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) -
          int.parse(changeKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  // Gives a warning to the user if current kilometer exceeded change kilometer.
  // If exceeded; that means the user forgot to change the consumable item.
  String? validateChangeKilometer(int index) {
    emit(ValidatingItem());
    if (calculateChangeKmAndCurrentKmDifference(index) > 0) {
      int difference = calculateChangeKmAndCurrentKmDifference(index);
      return "Warning, exceeded by ${difference.toThousands()} km";
    }
    emit(ValidatingComplete());
    return null;
  }
}
