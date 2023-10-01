import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LastChangedTextFormField extends StatelessWidget {
  const LastChangedTextFormField({
    super.key,
    required this.cubit,
    required this.index,
  });

  final ConsumableCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: AppDimens.edge8),
            child: TextFormField(
              key: index == 0 ? AppTourService.keyTextFieldLastChanged : null,
              controller: cubit.lastChangedAtControllers[index],
              focusNode: cubit.lastChangedAtFocuses[index],
              cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
              onChanged: (_) => cubit.getRemainingKm(index),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AppStrings.lastChangedAtLabel(context),
                floatingLabelStyle: TextStyle(
                  color: AppColors.getLastChangedAndChangeIntervalLabelColor(context, index, cubit),
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: AppColors.getLastChangedAndChangeIntervalFocusedBorder(context, index, cubit),
                enabledBorder: AppColors.getLastChangedAndChangeIntervalEnabledBorder(context, index, cubit),
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
            child: cubit.getLastChangedKmValidatingText(context, index),
          ),
        ],
      ),
    );
  }
}
