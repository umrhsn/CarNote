import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'consumables_state.dart';

class ConsumablesCubit extends Cubit<ConsumablesState> {
  ConsumablesCubit() : super(ConsumablesInitial());

  static ConsumablesCubit get(context) => BlocProvider.of<ConsumablesCubit>(context);

  final TextEditingController currentKmController = TextEditingController();

  final TextEditingController changeInterval1Controller = TextEditingController();
  final TextEditingController changeInterval2Controller = TextEditingController();
  final TextEditingController changeInterval3Controller = TextEditingController();
  final TextEditingController changeInterval4Controller = TextEditingController();
  final TextEditingController changeInterval5Controller = TextEditingController();
  final TextEditingController changeInterval6Controller = TextEditingController();
  final TextEditingController changeInterval7Controller = TextEditingController();
  final TextEditingController changeInterval8Controller = TextEditingController();
  final TextEditingController changeInterval9Controller = TextEditingController();

  final TextEditingController changeKm1Controller = TextEditingController();
  final TextEditingController changeKm2Controller = TextEditingController();
  final TextEditingController changeKm3Controller = TextEditingController();
  final TextEditingController changeKm4Controller = TextEditingController();
  final TextEditingController changeKm5Controller = TextEditingController();
  final TextEditingController changeKm6Controller = TextEditingController();
  final TextEditingController changeKm7Controller = TextEditingController();
  final TextEditingController changeKm8Controller = TextEditingController();
  final TextEditingController changeKm9Controller = TextEditingController();

  int _sumChangeKilometer(TextEditingController changeIntervalController) {
    if (currentKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
    }
    return 0;
  }

  void getChangeKilometer() {
    emit(AddingChangeKilometer());
    changeKm1Controller.text = _sumChangeKilometer(changeInterval1Controller) != 0
        ? _sumChangeKilometer(changeInterval1Controller).toThousands()
        : '';
    changeKm2Controller.text = _sumChangeKilometer(changeInterval2Controller) != 0
        ? _sumChangeKilometer(changeInterval2Controller).toThousands()
        : '';
    changeKm3Controller.text = _sumChangeKilometer(changeInterval3Controller) != 0
        ? _sumChangeKilometer(changeInterval3Controller).toThousands()
        : '';
    changeKm4Controller.text = _sumChangeKilometer(changeInterval4Controller) != 0
        ? _sumChangeKilometer(changeInterval4Controller).toThousands()
        : '';
    changeKm5Controller.text = _sumChangeKilometer(changeInterval5Controller) != 0
        ? _sumChangeKilometer(changeInterval5Controller).toThousands()
        : '';
    changeKm6Controller.text = _sumChangeKilometer(changeInterval6Controller) != 0
        ? _sumChangeKilometer(changeInterval6Controller).toThousands()
        : '';
    changeKm7Controller.text = _sumChangeKilometer(changeInterval7Controller) != 0
        ? _sumChangeKilometer(changeInterval7Controller).toThousands()
        : '';
    changeKm8Controller.text = _sumChangeKilometer(changeInterval8Controller) != 0
        ? _sumChangeKilometer(changeInterval8Controller).toThousands()
        : '';
    changeKm9Controller.text = _sumChangeKilometer(changeInterval9Controller) != 0
        ? _sumChangeKilometer(changeInterval9Controller).toThousands()
        : '';
    emit(AddedChangeKilometer());
  }
}
