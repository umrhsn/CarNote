import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';

class CarTypeTextFormField extends StatelessWidget {
  const CarTypeTextFormField({
    super.key,
    required this.carCubit,
    required this.validator,
  });

  final CarCubit carCubit;
  final FormValidation validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: carCubit.carTypeController,
      focusNode: carCubit.carTypeFocus,
      keyboardType: TextInputType.text,
      textAlign: TextAlign.start,
      hintText: AppStrings.carTypeHint(context),
      validationItem: validator.carType,
      validateItemForm: (value) => validator.validateCarTypeForm(value, context),
      onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, carCubit.modelYearFocus),
    );
  }
}
