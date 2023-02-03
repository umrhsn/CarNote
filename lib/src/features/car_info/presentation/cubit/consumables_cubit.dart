import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consumables_state.dart';

class ConsumablesCubit extends Cubit<ConsumablesState> {
  ConsumablesCubit() : super(ConsumablesInitial());

  static ConsumablesCubit get(context) => BlocProvider.of<ConsumablesCubit>(context);

  final TextEditingController currentKmController = TextEditingController();

  final List lastChangedAtControllers = [
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

  final List changeIntervalControllers = [
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

  final List changeKmControllers = [
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

  int _sumChangeKilometer(
      TextEditingController changedAtKmController, TextEditingController changeIntervalController) {
    if (changedAtKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      return int.parse(changedAtKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
    }
    return 0;
  }

  void getChangeKilometer() {
    emit(AddingChangeKilometer());
    changeKmControllers[0].text =
        _sumChangeKilometer(lastChangedAtControllers[0], changeIntervalControllers[0]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[0], changeIntervalControllers[0])
                .toThousands()
            : '';
    changeKmControllers[1].text =
        _sumChangeKilometer(lastChangedAtControllers[1], changeIntervalControllers[1]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[1], changeIntervalControllers[1])
                .toThousands()
            : '';
    changeKmControllers[2].text =
        _sumChangeKilometer(lastChangedAtControllers[2], changeIntervalControllers[2]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[2], changeIntervalControllers[2])
                .toThousands()
            : '';
    changeKmControllers[3].text =
        _sumChangeKilometer(lastChangedAtControllers[3], changeIntervalControllers[3]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[3], changeIntervalControllers[3])
                .toThousands()
            : '';
    changeKmControllers[4].text =
        _sumChangeKilometer(lastChangedAtControllers[4], changeIntervalControllers[4]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[4], changeIntervalControllers[4])
                .toThousands()
            : '';
    changeKmControllers[5].text =
        _sumChangeKilometer(lastChangedAtControllers[5], changeIntervalControllers[5]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[5], changeIntervalControllers[5])
                .toThousands()
            : '';
    changeKmControllers[6].text =
        _sumChangeKilometer(lastChangedAtControllers[6], changeIntervalControllers[6]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[6], changeIntervalControllers[6])
                .toThousands()
            : '';
    changeKmControllers[7].text =
        _sumChangeKilometer(lastChangedAtControllers[7], changeIntervalControllers[7]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[7], changeIntervalControllers[7])
                .toThousands()
            : '';
    changeKmControllers[8].text =
        _sumChangeKilometer(lastChangedAtControllers[8], changeIntervalControllers[8]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[8], changeIntervalControllers[8])
                .toThousands()
            : '';
    emit(AddedChangeKilometer());
  }
}
