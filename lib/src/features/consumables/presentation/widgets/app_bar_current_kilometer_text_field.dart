// lib/src/features/consumables/presentation/widgets/app_bar_current_kilometer_text_field.dart
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarCurrentKilometerTextField extends StatelessWidget {
  const AppBarCurrentKilometerTextField({
    super.key,
    required this.consumableCubit,
  });

  final ConsumableCubit consumableCubit;

  @override
  Widget build(BuildContext context) {
    // Get the current car info for display
    final car =
        consumableCubit.consumables.isNotEmpty ? "Car Info" : "No Car Data";

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        TextFormField(
          key: AppKeys.keyAppBarTextField,
          focusNode: consumableCubit.currentKmFocus,
          cursorColor: AppColors.getTextFieldBorderAndLabel(context),
          controller: consumableCubit.currentKmController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppStrings.fontFamily, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
              color: consumableCubit.currentKmFocus.hasFocus
                  ? AppColors.getTextFieldBorderAndLabelFocused(context)
                  : AppColors.getTextFieldBorderAndLabel(context),
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.getTextFieldBorderAndLabel(context),
              ),
            ),
            labelText: AppStrings.currentKmLabel(context),
            labelStyle:
                TextStyle(color: AppColors.getAppBarTextFieldLabel(context)),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(AppNums.lengthLimit9),
            FilteringTextInputFormatter.digitsOnly,
            ThousandSeparatorInputFormatter(),
          ],
          onChanged: (_) {
            consumableCubit.validateAllLastChangedKilometerFields(context);
            consumableCubit.validateAllChangeKilometerFields(context);
          },
          onEditingComplete: () =>
              consumableCubit.validateAllChangeKilometerFields(context),
          autovalidateMode: AutovalidateMode.always,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
              end: AppDimens.padding8, bottom: AppDimens.padding8),
          child: Text(
            car, // This will need to be updated to show actual car info
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: AppColors.getHintColor(context),
            ),
          ),
        ),
      ],
    );
  }
}
