import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consumables_state.dart';

class ConsumablesCubit extends Cubit<ConsumablesState> {
  ConsumablesCubit() : super(ConsumablesInitial());

  static ConsumablesCubit get(context) => BlocProvider.of<ConsumablesCubit>(context);

  bool shouldEnableSaveButton(BuildContext context) {
    for (int i = 0; i < lastChangedAtControllers.length; i++) {
      if (getLastChangedKmErrorText(context, i).data != '') {
        return false;
      }
    }
    return true;
  }

  final TextEditingController currentKmController = TextEditingController();

  final List<TextEditingController> lastChangedAtControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> changeIntervalControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List<TextEditingController> changeKmControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final List<FocusNode> changeIntervalFocuses = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final List<FocusNode> changeKmFocuses = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

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
    emit(AddingChangeKilometer());
    changeKmControllers[index].text =
        _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index])
                .toThousands()
            : '';
    emit(AddedChangeKilometer());
  }

  // TODO: find a cleaner code
  void validateAllLastChangedKilometerFields() {
    emit(Validating());
    for (int i = 0; i < changeKmControllers.length; i++) {
      validateLastChangedKilometer(i);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields() {
    emit(Validating());
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
    emit(ValidatingLastChangedKm());
    if (lastChangedAtControllers[index].text.isNotEmpty && currentKmController.text.isNotEmpty) {
      if (int.parse(lastChangedAtControllers[index].text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return "invalid input";
      }
    }
    emit(ValidatingLastChangedKmComplete());
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
    emit(ValidatingChangeKm());
    if (calculateChangeKmAndCurrentKmDifference(index) > 0) {
      int difference = calculateChangeKmAndCurrentKmDifference(index);
      return "Warning, exceeded by ${difference.toThousands()} km";
    }
    emit(ValidatingChangeKmComplete());
    return null;
  }
}
