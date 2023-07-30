import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/consumable_name_text_field.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// FIXME: doesn't show invalid text if present

class DialogConsumableWidget extends StatefulWidget {
  const DialogConsumableWidget({Key? key}) : super(key: key);

  @override
  State<DialogConsumableWidget> createState() => DialogConsumableWidgetState();
}

class DialogConsumableWidgetState extends State<DialogConsumableWidget> {
  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        cubit.getDialogLastChangedKmValidatingText(context).data != ''
            ? AppColors.getErrorColor(context)
            : cubit.lastChangedFocus.hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        cubit.getDialogLastChangedKmValidatingText(context).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        cubit.getDialogLastChangedKmValidatingText(context).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

    Color getChangeIntervalLabelColor() => cubit.changeIntervalFocus.hasFocus
        ? AppColors.getTextFieldBorderAndLabelFocused(context)
        : AppColors.getTextFieldBorderAndLabel(context);

    Expanded buildLastChangedTextFormField() {
      return Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: TextFormField(
                controller: cubit.lastChangedController,
                focusNode: cubit.lastChangedFocus,
                cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
                onChanged: (_) => cubit.getDialogLastChangedKmValidatingText(context),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppStrings.lastChangedAtLabel(context),
                  floatingLabelStyle: TextStyle(
                    color: getLastChangedAndChangeIntervalLabelColor(),
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: getLastChangedAndChangeIntervalFocusedBorder(),
                  enabledBorder: getLastChangedAndChangeIntervalEnabledBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandSeparatorInputFormatter(),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: cubit.getDialogLastChangedKmValidatingText(context),
            ),
          ],
        ),
      );
    }

    Expanded buildChangeIntervalTextFormField() {
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
              color: getChangeIntervalLabelColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(7),
            FilteringTextInputFormatter.digitsOnly,
            ThousandSeparatorInputFormatter(),
          ],
        ),
      );
    }

    return IntrinsicHeight(
      child: Column(
        children: [
          const ConsumableNameTextField(),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLastChangedTextFormField(),
              buildChangeIntervalTextFormField(),
            ],
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: AppStrings.saveData(context),
            btnEnabled: cubit.shouldEnableButton(context),
            onPressed: () {
              DatabaseHelper.addConsumable(
                name: cubit.consumableNameController.text,
                lastChangedAt:
                    int.parse(cubit.lastChangedController.text.removeThousandSeparator()),
                changeInterval:
                    int.parse(cubit.changeIntervalController.text.removeThousandSeparator()),
              );
              Navigator.pushReplacementNamed(context, Routes.consumablesRoute);
            },
          )
        ],
      ),
    );
  }
}
