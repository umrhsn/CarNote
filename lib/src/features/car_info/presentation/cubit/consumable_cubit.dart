import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/entities/consumable.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

part 'consumable_state.dart';

class ConsumableCubit extends Cubit<ConsumableState> {
  ConsumableCubit() : super(AppInitial()) {
    initFields();
  }

  static ConsumableCubit get(context) => BlocProvider.of<ConsumableCubit>(context);

  static final Box<Consumable> _consumableBox = Hive.box<Consumable>(AppStrings.consumableBox);

  final TextEditingController currentKmController = TextEditingController(
      text: CarCubit.carBox.get('car') != null
          ? CarCubit.carBox.get('car')!.currentKm != 0
              ? CarCubit.carBox.get('car')!.currentKm.toThousands()
              : ''
          : '');

  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> changeKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> changeKmFocuses = [];

  void initFields() {
    // TODO: depend on _myBox.length
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

      debugPrint('lastChangedAtControllers[$index].text = ${lastChangedAtControllers[index].text}');
      debugPrint(
          'changeIntervalControllers[$index].text = ${changeIntervalControllers[index].text}');
      debugPrint('changeKmControllers[$index].text = ${changeKmControllers[index].text}');
    }
  }

  void writeData() {
    CarCubit.carBox.put(
      'car',
      Car(
        type: CarCubit.carBox.get('car')!.type,
        modelYear: CarCubit.carBox.get('car')!.modelYear,
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
      debugPrint('${_consumableBox.get(index)}');
      debugPrint(_consumableBox.get(index)!.name);
      debugPrint(_consumableBox.get(index)!.lastChangedAt.toThousands());
      debugPrint(_consumableBox.get(index)!.changeInterval.toThousands());
      debugPrint(_consumableBox.get(index)!.changeKm.toThousands());

      if (_consumableBox.get(index) == null) {
        isNotNull = false;
      }
    }

    if (isNotNull) {
      Fluttertoast.showToast(msg: AppStrings.dataAddedSuccessfully);
    } else {
      Fluttertoast.showToast(msg: AppStrings.somethingWentWrong);
    }
  }

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
