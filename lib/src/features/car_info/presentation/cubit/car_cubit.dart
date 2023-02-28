import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());

  /// Easy access object of Cubit
  static CarCubit get(BuildContext context) => BlocProvider.of<CarCubit>(context);

  /// Main fields
  final TextEditingController carTypeController = TextEditingController(
      text: _carBox.get(AppStrings.carBox) != null
          ? _carBox.get(AppStrings.carBox)!.type.isNotEmpty
              ? _carBox.get(AppStrings.carBox)!.type
              : null
          : null);

  final TextEditingController modelYearController = TextEditingController(
      text: _carBox.get(AppStrings.carBox) != null
          ? _carBox.get(AppStrings.carBox)!.modelYear != 0
              ? _carBox.get(AppStrings.carBox)!.modelYear.toString()
              : null
          : null);

  final TextEditingController currentKmController = TextEditingController(
      text: _carBox.get(AppStrings.carBox) != null
          ? _carBox.get(AppStrings.carBox)!.currentKm != 0
              ? _carBox.get(AppStrings.carBox)!.currentKm.toThousands()
              : null
          : null);

  final FocusNode carTypeFocus = FocusNode();
  final FocusNode modelYearFocus = FocusNode();
  final FocusNode currentKmFocus = FocusNode();

  /// Database fields and methods
  static final Box<Car> _carBox = Hive.box<Car>(AppStrings.carBox);

  static Box<Car> get carBox => _carBox;

  void writeDataAndNavigate(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _carBox.put(
      AppStrings.carBox,
      Car(
        type: carTypeController.text,
        modelYear: int.parse(modelYearController.text),
        currentKm: int.parse(currentKmController.text.removeThousandSeparator()),
      ),
    );

    if (_carBox.get(AppStrings.carBox) != null) {
      await prefs.setBool(AppStrings.prefsBoolSeen, true);
      Fluttertoast.showToast(msg: AppStrings.dataAddedSuccessfully);
      Navigator.pushReplacementNamed(context, Routes.consumablesRoute);
    } else {
      Fluttertoast.showToast(msg: AppStrings.somethingWentWrong);
    }
  }

// TODO: move to Bloc instead of Provider
// OutlineInputBorder getFocusedBorder(BuildContext context) => OutlineInputBorder(
//       borderSide: BorderSide(
//         color: context.isLight
//             ? AppColors.appBarFocusedPrimaryLight
//             : AppColors.appBarFocusedPrimaryDark,
//         strokeAlign: 0,
//         width: 1.2,
//       ),
//     );
//
// OutlineInputBorder getDefaultBorder(BuildContext context) => OutlineInputBorder(
//       borderSide: BorderSide(
//         color: context.isLight ? AppColors.hintLight : AppColors.hintDark,
//         width: 1.2,
//         strokeAlign: 0,
//       ),
//     );
//
// OutlineInputBorder getErrorBorder(BuildContext context) => OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Theme.of(context).colorScheme.error,
//         width: 2,
//       ),
//     );
//
// OutlineInputBorder getWarningBorder(BuildContext context) => OutlineInputBorder(
//       borderSide: BorderSide(
//         color: context.isLight ? AppColors.warningLight : AppColors.warningDark,
//         width: 2,
//       ),
//     );
//
// bool shouldEnableContinueButton(BuildContext context) {
//   if (getCarTypeValidatingText(context).data != '' ||
//       getModelYearValidatingText(context).data != '' ||
//       getCurrentKmValidatingText(context).data != '') {
//     return false;
//   }
//   return true;
// }
//
// String? validateCarType() {
//   emit(ValidatingItem());
//   if (carTypeController.text == '') {
//     emit(ValidatingComplete());
//     return AppStrings.requiredField;
//   }
//   emit(ValidatingComplete());
//   return null;
// }
//
// String? _validateModelYear() {
//   emit(ValidatingItem());
//
//   if (modelYearController.text == '') {
//     emit(ValidatingComplete());
//     return AppStrings.requiredField;
//   } else {
//     if (modelYearController.text != '' && modelYearController.text.length < 4) {
//       emit(ValidatingComplete());
//       return AppStrings.yearMatchesLength;
//     } else if (int.parse(modelYearController.text) > (DateTime.now().year + 1)) {
//       emit(ValidatingComplete());
//       return AppStrings.yearNotValid;
//     }
//   }
//   emit(ValidatingComplete());
//   return null;
// }
//
// String? _validateCurrentKm() {
//   emit(ValidatingItem());
//   if (currentKmController.text == '') {
//     emit(ValidatingComplete());
//     return AppStrings.requiredField;
//   }
//   emit(ValidatingComplete());
//   return null;
// }
//
// Text getCarTypeValidatingText(BuildContext context) {
//   emit(GettingValidatingText());
//   return Text(
//     validateCarType() ?? '',
//     style: TextStyle(
//       color: AppColors.getErrorColor(context),
//       height: validateCarType() != null ? 2 : 0,
//       fontSize: 11,
//     ),
//   );
// }
//
// Text getModelYearValidatingText(BuildContext context) {
//   return Text(
//     _validateModelYear() ?? '',
//     style: TextStyle(
//       color: AppColors.getErrorColor(context),
//       height: _validateModelYear() != null ? 2 : 0,
//       fontSize: 11,
//     ),
//   );
// }
//
// Text getCurrentKmValidatingText(BuildContext context) {
//   return Text(
//     _validateCurrentKm() ?? '',
//     style: TextStyle(
//       color: AppColors.getErrorColor(context),
//       height: _validateCurrentKm() != null ? 2 : 0,
//       fontSize: 11,
//     ),
//   );
// }
}
