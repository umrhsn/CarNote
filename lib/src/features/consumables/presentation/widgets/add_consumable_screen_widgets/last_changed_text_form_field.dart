import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_input_borders.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/custom_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LastChangedTextFormField extends StatelessWidget {
  const LastChangedTextFormField({
    super.key,
    required this.cubit,
  });

  final ConsumableCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppDimens.padding8),
            child: TextFormField(
              controller: cubit.lastChangedController,
              focusNode: cubit.lastChangedFocus,
              cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
              onChanged: (_) => cubit.getAddLastChangedKmValidatingText(context),
              onEditingComplete: () => CustomTextFormField.requestFocus(context, cubit.changeIntervalFocus),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AppStrings.lastChangedAtLabel(context),
                floatingLabelStyle: TextStyle(
                  color: AppColors.getLastChangedAndChangeIntervalLabelColor(context, cubit: cubit),
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: AppInputBorders.getLastChangedAndChangeIntervalFocusedBorder(context, cubit: cubit),
                enabledBorder: AppInputBorders.getLastChangedAndChangeIntervalEnabledBorder(context, cubit: cubit),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(AppNums.lengthLimit9),
                FilteringTextInputFormatter.digitsOnly,
                ThousandSeparatorInputFormatter(),
              ],
              style: TextStyle(fontFamily: AppStrings.fontFamily),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: cubit.getAddLastChangedKmValidatingText(context),
          ),
        ],
      ),
    );
  }
}
