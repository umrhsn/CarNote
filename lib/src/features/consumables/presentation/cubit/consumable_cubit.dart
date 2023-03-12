import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

part 'consumable_state.dart';

class ConsumableCubit extends Cubit<ConsumableState> {
  ConsumableCubit() : super(AppInitial()) {
    // TODO: depend on _consumableBox.length
    for (int index = 0; index < Consumable.getCount(); index++) {
      lastChangedAtControllers.add(
        TextEditingController(
          text: _consumableBox.get(index) != null
              ? _consumableBox.get(index)!.lastChangedAt != 0
                  ? _consumableBox.get(index)!.lastChangedAt.toThousands()
                  : ''
              : '',
        ),
      );
      changeIntervalControllers.add(
        TextEditingController(
          text: _consumableBox.get(index) != null
              ? _consumableBox.get(index)!.changeInterval != 0
                  ? _consumableBox.get(index)!.changeInterval.toThousands()
                  : ''
              : '',
        ),
      );
      changeKmControllers.add(
        TextEditingController(
          text: _consumableBox.get(index) != null
              ? _consumableBox.get(index)!.changeKm != 0
                  ? _consumableBox.get(index)!.changeKm.toThousands()
                  : ''
              : '',
        ),
      );
      lastChangedAtFocuses.add(FocusNode());
      changeIntervalFocuses.add(FocusNode());
      changeKmFocuses.add(FocusNode());
    }
  }

  /// Easy access object of Cubit
  static ConsumableCubit get(BuildContext context) => BlocProvider.of<ConsumableCubit>(context);

  /// Main fields
  final TextEditingController currentKmController = TextEditingController(
      text: CarCubit.carBox.get(AppStrings.carBox) != null
          ? CarCubit.carBox.get(AppStrings.carBox)!.currentKm != 0
              ? CarCubit.carBox.get(AppStrings.carBox)!.currentKm.toThousands()
              : ''
          : '');

  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> changeKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> changeKmFocuses = [];

  /// Database fields and methods
  static final Box<Consumable> _consumableBox = Hive.box<Consumable>(AppStrings.consumableBox);

  static Box<Consumable> get consumableBox => _consumableBox;

  void writeData() {
    CarCubit.carBox.put(
      AppStrings.carBox,
      Car(
        type: CarCubit.carBox.get(AppStrings.carBox)!.type,
        modelYear: CarCubit.carBox.get(AppStrings.carBox)!.modelYear,
        currentKm: int.parse(currentKmController.text.removeThousandSeparator()),
      ),
    );

    bool isNotNull = true;

    for (int index = 0; index < Consumable.getCount(); index++) {
      _consumableBox.put(
        index,
        Consumable(
          id: index,
          name: AppStrings.consumables[index],
          lastChangedAt: lastChangedAtControllers[index].text.isNotEmpty
              ? int.parse(lastChangedAtControllers[index].text.removeThousandSeparator())
              : 0,
          changeInterval: changeIntervalControllers[index].text.isNotEmpty
              ? int.parse(changeIntervalControllers[index].text.removeThousandSeparator())
              : 0,
          changeKm: changeKmControllers[index].text.isNotEmpty
              ? int.parse(changeKmControllers[index].text.removeThousandSeparator())
              : 0,
        ),
      );
      if (_consumableBox.get(index) == null) isNotNull = false;
    }

    if (isNotNull) {
      BotToast.showText(text: AppStrings.dataAddedSuccessfully);
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong);
    }
  }

  /// Color controlling methods
  Color getValidatingTextColor(BuildContext context, int index) => isNormalText(index)
      ? AppColors.getHintColor(context)
      : isWarningText(index)
          ? AppColors.getWarningColor(context)
          : AppColors.getErrorColor(context);

  OutlineInputBorder getFocusedBorder(BuildContext context) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getTextFieldBorderAndLabelFocused(context),
          strokeAlign: 0,
          width: 1.2,
        ),
      );

  OutlineInputBorder getDefaultBorder(BuildContext context) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getHintColor(context),
          width: 1.2,
          strokeAlign: 0,
        ),
      );

  OutlineInputBorder getErrorBorder(BuildContext context) =>
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.getErrorColor(context), width: 2));

  OutlineInputBorder getWarningBorder(BuildContext context) => OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.getWarningColor(context), width: 2));

  bool shouldEnableSaveButton(BuildContext context) {
    for (int index = 0; index < lastChangedAtControllers.length; index++) {
      if (getLastChangedKmValidatingText(context, index).data != '') {
        return false;
      }
    }
    return true;
  }

  /// Error and warning Text widgets
  Text getLastChangedKmValidatingText(BuildContext context, int index) => Text(
        _validateLastChangedKilometer(index) ?? '',
        style: TextStyle(
          color: AppColors.getErrorColor(context),
          height: _validateLastChangedKilometer(index) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  Text getChangeKmValidatingText(BuildContext context, int index) => Text(
        _validateChangeKilometer(index, context) ?? '',
        style: TextStyle(
          color: getValidatingTextColor(context, index),
          height: _validateChangeKilometer(index, context) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  /// Calculation and validation methods
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
    for (int index = 0; index < changeKmControllers.length; index++) {
      _validateLastChangedKilometer(index);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields(BuildContext context) {
    emit(ValidatingItem());
    for (int index = 0; index < changeKmControllers.length; index++) {
      _validateChangeKilometer(index, context);
    }
    emit(ValidatingComplete());
  }

  // last changed kilometer should not exceed current kilometer
  String? _validateLastChangedKilometer(int index) {
    emit(ValidatingItem());
    if (lastChangedAtControllers[index].text.isNotEmpty && currentKmController.text.isNotEmpty) {
      if (int.parse(lastChangedAtControllers[index].text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return AppStrings.invalidInput;
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

  int calculateWarningDifference(int index) {
    if (currentKmController.text.isNotEmpty && changeKmControllers[index].text.isNotEmpty) {
      if (int.parse(currentKmController.text.removeThousandSeparator()) <
          int.parse(changeKmControllers[index].text.removeThousandSeparator())) {
        return int.parse(changeKmControllers[index].text.removeThousandSeparator()) -
            int.parse(currentKmController.text.removeThousandSeparator());
      }
    }
    return 0;
  }

  bool isNormalText(int index) {
    emit(Calculating());
    return calculateWarningDifference(index) > 500;
  }

  bool isWarningText(int index) {
    emit(Calculating());
    return calculateWarningDifference(index) > 0 && calculateWarningDifference(index) <= 500;
  }

  bool isErrorText(int index) {
    emit(Calculating());
    return calculateChangeKmAndCurrentKmDifference(index) > 0;
  }

  // Gives an error message to the user if current kilometer exceeded change kilometer.
  // If exceeded; that means the user forgot to change the consumable item.
  String? _validateChangeKilometer(int index, BuildContext context) {
    emit(ValidatingItem());
    if (isNormalText(index)) {
      emit(ValidatingComplete());
      return '${calculateWarningDifference(index).toThousands()} ${AppStrings.km} ${AppStrings.remaining}';
    }
    if (isWarningText(index)) {
      emit(ValidatingComplete());
      return '${calculateWarningDifference(index).toThousands()} ${AppStrings.km} ${AppStrings.warningText}';
    }
    if (isErrorText(index)) {
      emit(ValidatingComplete());
      return '${AppStrings.errorText} ${calculateChangeKmAndCurrentKmDifference(index).toThousands()} ${AppStrings.km}';
    }
    emit(ValidatingComplete());
    return null;
  }

  /// Control widgets visibility
  void changeVisibility() {
    bool visible = di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolVisible) ?? true;
    emit(VisibilityChanging());
    visible = !visible;
    visible
        ? BotToast.showText(text: AppStrings.detailedModeOn)
        : BotToast.showText(text: AppStrings.detailedModeOff);
    di.sl<SharedPreferences>().setBool(AppStrings.prefsBoolVisible, visible);
    emit(VisibilityChanged());
  }
}
