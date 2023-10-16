import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_input_borders.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class RemainingKilometerTextFormField extends StatelessWidget {
  const RemainingKilometerTextFormField({
    super.key,
    required this.cubit,
    required this.index,
  });

  final ConsumableCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: index == 0 ? AppKeys.keyTextFieldRemaining : null,
          enabled: false,
          controller: cubit.remainingKmControllers[index],
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.getNormalTextColor(context),
            fontFamily: AppStrings.fontFamily,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            labelText: cubit.isErrorText(index) ? AppStrings.remainingKmErrorLabel(context) : AppStrings.remainingKmNormalWarningLabel(context),
            fillColor: AppColors.getDisabledTextFieldFill(context),
            floatingLabelStyle:
                TextStyle(color: AppColors.getRemainingKmLabelColor(context, cubit: cubit, index: index), fontWeight: FontWeight.bold),
            disabledBorder: AppInputBorders.getRemainingKmDisabledBorder(context, cubit: cubit, index: index),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: AppTexts.getRemainingKmValidatingText(context, cubit: cubit, index: index),
        )
      ],
    );
  }
}
