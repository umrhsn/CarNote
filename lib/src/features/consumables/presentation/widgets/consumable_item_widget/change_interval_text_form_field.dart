import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeIntervalTextFormField extends StatelessWidget {
  const ChangeIntervalTextFormField({super.key, required this.cubit, required this.index});

  final ConsumableCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        key: index == 0 ? AppTourService.keyTextFieldChangeInterval : null,
        controller: cubit.changeIntervalControllers[index],
        focusNode: cubit.changeIntervalFocuses[index],
        cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
        onChanged: (_) => cubit.getRemainingKm(index),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: AppStrings.changeIntervalLabel(context),
          floatingLabelStyle: TextStyle(
            color: AppColors.getChangeIntervalLabelColor(context, index, cubit),
            fontWeight: FontWeight.bold,
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(7),
          FilteringTextInputFormatter.digitsOnly,
          ThousandSeparatorInputFormatter(),
        ],
        style: TextStyle(fontFamily: AppStrings.fontFamily),
      ),
    );
  }
}
