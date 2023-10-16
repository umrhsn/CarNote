import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

part 'consumable_state.dart';

class ConsumableCubit extends Cubit<ConsumableState> {
  ConsumableCubit() : super(AppInitial()) {
    List? list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox);

    for (int index = 0; index < Consumable.getCount(); index++) {
      Consumable item = list![index];

      lastChangedAtControllers.add(TextEditingController(text: item.lastChangedAt != 0 ? item.lastChangedAt.toThousands() : ''));
      changeIntervalControllers.add(TextEditingController(text: item.changeInterval != 0 ? item.changeInterval.toThousands() : ''));
      remainingKmControllers.add(TextEditingController(
          text: item.remainingKm != 0
              ? item.remainingKm.toThousands()
              : lastChangedAtControllers[index].text.isNotEmpty && changeIntervalControllers[index].text.isNotEmpty
                  ? ''
                  : '0'));

      lastChangedAtFocuses.add(FocusNode());
      changeIntervalFocuses.add(FocusNode());
      remainingKmFocuses.add(FocusNode());
    }
  }

  /// Easy access object of Cubit
  static ConsumableCubit get(BuildContext context) => BlocProvider.of<ConsumableCubit>(context);

  /// Main fields
  final TextEditingController currentKmController = TextEditingController(
      text: DatabaseHelper.carBox.get(AppKeys.carBox) != null
          ? DatabaseHelper.carBox.get(AppKeys.carBox)!.currentKm != 0
              ? DatabaseHelper.carBox.get(AppKeys.carBox)!.currentKm.toThousands()
              : ''
          : '');

  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> remainingKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> remainingKmFocuses = [];

  bool shouldEnableButtons(BuildContext context) {
    for (int index = 0; index < lastChangedAtControllers.length; index++) {
      if (currentKmController.text.isEmpty || AppTexts.getLastChangedKmValidatingText(context, cubit: ConsumableCubit.get(context), index: index).data != '') {
        return false;
      }
    }
    return true;
  }

  /// Calculation and validation methods
  int _calculateRemainingKm(TextEditingController lastChangedAtKmController, TextEditingController changeIntervalController) {
    if (currentKmController.text.isNotEmpty && lastChangedAtKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      int changeKm =
          int.parse(lastChangedAtKmController.text.removeThousandSeparator()) + int.parse(changeIntervalController.text.removeThousandSeparator());
      return int.parse(currentKmController.text.removeThousandSeparator()) - changeKm;
    }
    return 0;
  }

  void getRemainingKm(int index) {
    emit(AddingRemainingKm());
    remainingKmControllers[index].text = currentKmController.text.isNotEmpty
        ? _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) != 0
            ? _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) < 0
                ? (_calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) * -1).toThousands()
                : _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]).toThousands()
            : lastChangedAtControllers[index].text.isNotEmpty && changeIntervalControllers[index].text.isNotEmpty
                ? '0'
                : ''
        : '';
    emit(AddedRemainingKm());
  }

  void validateAllLastChangedKilometerFields(BuildContext context) {
    emit(ValidatingItem());
    // FIXME
    for (int index = 0; index < Consumable.getCount(); index++) {
      validateLastChangedKilometer(index, context);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields(BuildContext context) {
    emit(ValidatingItem());
    for (int index = 0; index < Consumable.getCount(); index++) {
      validateRemainingKilometer(index, context);
    }
    emit(ValidatingComplete());
  }

  // current kilometer should not be empty
  String? validateCurrentKilometer(BuildContext context) {
    emit(ValidatingItem());
    if (currentKmController.text.isEmpty) return AppStrings.invalidInput(context);
    emit(ValidatingComplete());
    return null;
  }

  // last changed kilometer should not exceed current kilometer
  String? validateLastChangedKilometer(int index, BuildContext context) {
    emit(ValidatingItem());
    if (lastChangedAtControllers[index].text.isNotEmpty && currentKmController.text.isNotEmpty) {
      if (int.parse(lastChangedAtControllers[index].text.removeThousandSeparator()) > int.parse(currentKmController.text.removeThousandSeparator())) {
        return AppStrings.invalidInput(context);
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  int calculateRemainingKmAndCurrentKmDifference(int index) {
    if (currentKmController.text.isNotEmpty && remainingKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) - int.parse(remainingKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  int _calculateChangeKmAndCurrentKmSum(int index) {
    if (currentKmController.text.isNotEmpty && remainingKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) + int.parse(remainingKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  int calculateWarningDifference(int index) {
    if (currentKmController.text.isNotEmpty && remainingKmControllers[index].text.isNotEmpty) {
      if (int.parse(currentKmController.text.removeThousandSeparator()) < int.parse(remainingKmControllers[index].text.removeThousandSeparator())) {
        return int.parse(remainingKmControllers[index].text.removeThousandSeparator()) -
            int.parse(currentKmController.text.removeThousandSeparator());
      }
    }
    return 0;
  }

  bool isNormalText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty && _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) < -500;
  }

  bool isConsiderText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty &&
        _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) == 0 &&
        lastChangedAtControllers[index].text.isNotEmpty &&
        changeIntervalControllers[index].text.isNotEmpty;
  }

  bool isWarningText(int index) {
    emit(Calculating());
    return currentKmController.text.isNotEmpty &&
        _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) >= -500 &&
        _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) < 0;
  }

  bool isErrorText(int index) {
    emit(Calculating());
    return _calculateRemainingKm(lastChangedAtControllers[index], changeIntervalControllers[index]) > 0;
  }

  // Gives an error message to the user if current kilometer exceeded change kilometer.
  // If exceeded; that means the user forgot to change the consumable item.
  String? validateRemainingKilometer(int index, BuildContext context) {
    emit(ValidatingItem());
    if (isNormalText(index) || isWarningText(index)) {
      emit(ValidatingComplete());
      return '${AppStrings.normalAndWarningText(context)} ${_calculateChangeKmAndCurrentKmSum(index).toThousands()}';
    }
    if (isConsiderText(index)) {
      emit(ValidatingComplete());
      return AppStrings.considerText(context);
    }
    if (isErrorText(index)) {
      emit(ValidatingComplete());
      return '${AppStrings.errorText(context)} ${calculateRemainingKmAndCurrentKmDifference(index).toThousands()}';
    }
    emit(ValidatingComplete());
    return null;
  }

  /// Control widgets visibility
  void changeVisibility(BuildContext context) {
    bool visible = di.sl<SharedPreferences>().getBool(AppKeys.prefsBoolDetailedModeOn) ?? true;
    emit(VisibilityChanging());
    visible = !visible;
    visible ? BotToast.showText(text: AppStrings.detailedModeOn(context)) : BotToast.showText(text: AppStrings.detailedModeOff(context));
    di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolDetailedModeOn, visible);
    emit(VisibilityChanged());
  }

  /// Add Consumable Widget
  TextEditingController consumableNameController = TextEditingController();
  TextEditingController lastChangedController = TextEditingController();
  TextEditingController changeIntervalController = TextEditingController();
  FocusNode lastChangedFocus = FocusNode();
  FocusNode changeIntervalFocus = FocusNode();

  Text getAddLastChangedKmValidatingText(BuildContext context) => Text(
        _validateAddLastChangedKilometer(context) ?? '',
        style: TextStyle(
          color: AppColors.getErrorColor(context),
          height: _validateAddLastChangedKilometer(context) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  String? _validateAddLastChangedKilometer(BuildContext context) {
    emit(ValidatingItem());
    if (lastChangedController.text.isNotEmpty) {
      if (int.parse(lastChangedController.text.removeThousandSeparator()) > int.parse(currentKmController.text.removeThousandSeparator())) {
        return AppStrings.invalidInput(context);
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  bool shouldEnableAddButton(BuildContext context) {
    if (consumableNameController.text.isEmpty || lastChangedController.text.isEmpty || changeIntervalController.text.isEmpty) return false;

    if (_validateAddLastChangedKilometer(context) != null) return false;

    return true;
  }
}
