import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModelYearTextFormField extends StatelessWidget {
  const ModelYearTextFormField({
    super.key,
    required this.carCubit,
    required this.validator,
  });

  final CarCubit carCubit;
  final FormValidation validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: carCubit.modelYearController,
      focusNode: carCubit.modelYearFocus,
      textAlign: TextAlign.start,
      hintText: AppStrings.modelYearHint(context),
      inputFormatters: [
        LengthLimitingTextInputFormatter(AppNums.lengthLimit4),
        FilteringTextInputFormatter.digitsOnly,
      ],
      style: TextStyle(fontFamily: AppStrings.fontFamily),
      validationItem: validator.modelYear,
      validateItemForm: (value) => validator.validateModelYearForm(value, context),
      onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, carCubit.currentKmFocus),
    );
  }
}
