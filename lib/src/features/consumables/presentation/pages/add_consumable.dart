import 'package:bot_toast/bot_toast.dart';
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

class AddConsumable extends StatefulWidget {
  const AddConsumable({Key? key}) : super(key: key);

  @override
  State<AddConsumable> createState() => AddConsumableState();
}

class AddConsumableState extends State<AddConsumable> {
  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
            ? AppColors.getErrorColor(context)
            : cubit.lastChangedFocus.hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
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
                onChanged: (_) => cubit.getAddLastChangedKmValidatingText(context),
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
              child: cubit.getAddLastChangedKmValidatingText(context),
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.getPrimaryColor(context),
        toolbarHeight: 100,
        title: Text(
          AppStrings.addConsumable(context),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ConsumableNameTextField(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLastChangedTextFormField(),
                buildChangeIntervalTextFormField(),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: AppStrings.addConsumable(context).toUpperCase(),
                    btnEnabled: true,
                    onPressed: () {
                      DatabaseHelper.addConsumable(
                        context,
                        name: cubit.consumableNameController.text,
                        lastChangedAt: cubit.lastChangedController.text.isEmpty
                            ? 0
                            : int.parse(cubit.lastChangedController.text.removeThousandSeparator()),
                        changeInterval: cubit.changeIntervalController.text.isEmpty
                            ? 0
                            : int.parse(
                                cubit.changeIntervalController.text.removeThousandSeparator()),
                      ).then((value) {
                        if (value) {
                          BotToast.showText(text: AppStrings.itemAdded(context));
                          Navigator.pop(context);
                        } else {
                          BotToast.showText(text: AppStrings.invalidInput(context));
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    text: AppStrings.cancel(context).toUpperCase(),
                    onPressed: () => Navigator.pop(context),
                    btnEnabled: true,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
