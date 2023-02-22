import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/presentation/pages/consumables_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());

  static CarCubit get(context) => BlocProvider.of<CarCubit>(context);

  static final Box<Car> _carBox = Hive.box<Car>(AppStrings.carBox);

  static Box<Car> get carBox => _carBox;

  final TextEditingController carTypeController = TextEditingController(
      text: _carBox.get('car') != null
          ? _carBox.get('car')!.type.isNotEmpty
              ? _carBox.get('car')!.type
              : ''
          : '');

  final TextEditingController modelYearController = TextEditingController(
      text: _carBox.get('car') != null
          ? _carBox.get('car')!.modelYear != 0
              ? _carBox.get('car')!.modelYear.toString()
              : ''
          : '');

  final TextEditingController currentKmController = TextEditingController(
      text: _carBox.get('car') != null
          ? _carBox.get('car')!.currentKm != 0
              ? _carBox.get('car')!.currentKm.toThousands()
              : ''
          : '');

  final FocusNode carTypeFocus = FocusNode();
  final FocusNode modelYearFocus = FocusNode();
  final FocusNode currentKmFocus = FocusNode();

  void writeDataAndNavigate(BuildContext context) {
    _carBox.put(
      'car',
      Car(
        type: carTypeController.text,
        modelYear: int.parse(modelYearController.text),
        currentKm: int.parse(currentKmController.text.removeThousandSeparator()),
      ),
    );

    debugPrint('${_carBox.get('car')}');
    debugPrint(_carBox.get('car')!.type);
    debugPrint('${_carBox.get('car')!.modelYear}');
    debugPrint(_carBox.get('car')!.currentKm.toThousands());

    if (_carBox.get('car') != null) {
      Fluttertoast.showToast(msg: AppStrings.dataAddedSuccessfully);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const ConsumablesScreen();
      }));
    } else {
      Fluttertoast.showToast(msg: AppStrings.somethingWentWrong);
    }
  }
}
