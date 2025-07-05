// lib/src/features/car_info/presentation/widgets/continue_button.dart
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.validator,
    required this.carCubit,
  });

  final FormValidation validator;
  final CarCubit carCubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      text: AppStrings.btnContinue(context),
      btnEnabled: validator.isValid,
      onPressed: () async {
        await carCubit.saveCar(context);
      },
    );
  }
}
