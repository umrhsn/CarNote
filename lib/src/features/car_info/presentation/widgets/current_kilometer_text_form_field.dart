import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrentKilometerTextFormField extends StatelessWidget {
  const CurrentKilometerTextFormField({
    super.key,
    required this.carCubit,
    required this.validator,
  });

  final CarCubit carCubit;
  final FormValidation validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: carCubit.currentKmController,
      focusNode: carCubit.currentKmFocus,
      textAlign: TextAlign.start,
      textInputAction: TextInputAction.done,
      inputFormatters: [
        LengthLimitingTextInputFormatter(AppNums.lengthLimit9),
        FilteringTextInputFormatter.digitsOnly,
        ThousandSeparatorInputFormatter(),
      ],
      style: TextStyle(fontFamily: AppStrings.fontFamily),
      hintText: AppStrings.currentKmCarInfoScreenHint(context),
      validationItem: validator.currentKm,
      validateItemForm: (value) => validator.validateCurrentKmForm(value, context),
      onFieldSubmitted: (_) => DatabaseHelper.writeCarData(context).then((value) => carCubit.navigateToConsumablesScreen(context)),
    );
  }
}
