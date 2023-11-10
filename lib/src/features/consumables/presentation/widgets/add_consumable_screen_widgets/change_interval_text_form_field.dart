import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeIntervalTextFormField extends StatelessWidget {
  const ChangeIntervalTextFormField({
    super.key,
    required this.cubit,
  });

  final ConsumableCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: cubit.changeIntervalController,
        focusNode: cubit.changeIntervalFocus,
        cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: AppStrings.changeIntervalLabel(context),
          floatingLabelStyle: TextStyle(
            color: AppColors.getChangeIntervalLabelColor(context, cubit: cubit),
            fontWeight: FontWeight.bold,
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(AppNums.lengthLimit7),
          FilteringTextInputFormatter.digitsOnly,
          ThousandSeparatorInputFormatter(),
        ],
        style: TextStyle(fontFamily: AppStrings.fontFamily),
      ),
    );
  }
}
