import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsumableWidget extends StatefulWidget {
  final int index;
  final String name;

  const ConsumableWidget({Key? key, required this.index, required this.name}) : super(key: key);

  @override
  State<ConsumableWidget> createState() => ConsumableWidgetState();
}

class ConsumableWidgetState extends State<ConsumableWidget> {
  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    cubit.calculateChangeKmAndCurrentKmDifference(widget.index);
    cubit.getChangeKilometer(widget.index);

    OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
          color: context.isLight
              ? AppColors.appBarFocusedPrimaryLight
              : AppColors.appBarFocusedPrimaryDark,
          strokeAlign: 0,
          width: 1.2),
    );

    OutlineInputBorder defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: context.isLight ? AppColors.hintLight : AppColors.hintDark,
        width: 1.2,
        strokeAlign: 0,
      ),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Theme.of(context).colorScheme.error, width: 2),
    );

    Expanded buildLastChangedTextFormField() {
      return Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextFormField(
                controller: cubit.lastChangedAtControllers[widget.index],
                focusNode: cubit.lastChangedAtFocuses[widget.index],
                cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
                onChanged: (_) => cubit.getChangeKilometer(widget.index),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppStrings.lastChangedAtLabel,
                  floatingLabelStyle: TextStyle(
                    color: cubit.getLastChangedKmErrorText(context, widget.index).data != ''
                        ? Theme.of(context).colorScheme.error
                        : cubit.lastChangedAtFocuses[widget.index].hasFocus
                            ? AppColors.getTextFieldBorderAndLabelFocused(context)
                            : AppColors.getTextFieldBorderAndLabel(context),
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: cubit.getLastChangedKmErrorText(context, widget.index).data != ''
                      ? errorBorder
                      : focusedBorder,
                  enabledBorder: cubit.getLastChangedKmErrorText(context, widget.index).data != ''
                      ? errorBorder
                      : defaultBorder,
                ),
                inputFormatters: [
                  ThousandSeparatorTextInputFormatter(),
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: cubit.getLastChangedKmErrorText(context, widget.index),
            ),
          ],
        ),
      );
    }

    Expanded buildChangeIntervalTextFormField() {
      return Expanded(
          child: TextFormField(
        controller: cubit.changeIntervalControllers[widget.index],
        focusNode: cubit.changeIntervalFocuses[widget.index],
        cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
        onChanged: (_) => cubit.getChangeKilometer(widget.index),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: AppStrings.changeIntervalLabel,
          floatingLabelStyle: TextStyle(
            color: cubit.changeIntervalFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        inputFormatters: [
          ThousandSeparatorTextInputFormatter(),
          LengthLimitingTextInputFormatter(7),
        ],
      ));
    }

    Column buildChangeKmTextFormField() {
      return Column(
        children: [
          TextFormField(
            enabled: false,
            controller: cubit.changeKmControllers[widget.index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: AppStrings.changeKmLabel,
              fillColor: context.isLight
                  ? AppColors.primaryLight.withAlpha(20)
                  : AppColors.primaryDark.withAlpha(90),
              floatingLabelStyle: TextStyle(
                color: cubit.getChangeKmErrorText(context, widget.index).data != ''
                    ? Theme.of(context).colorScheme.error
                    : cubit.changeKmFocuses[widget.index].hasFocus
                        ? AppColors.getTextFieldBorderAndLabelFocused(context)
                        : AppColors.getTextFieldBorderAndLabel(context),
                fontWeight: FontWeight.bold,
              ),
              disabledBorder: cubit.getChangeKmErrorText(context, widget.index).data != ''
                  ? errorBorder
                  : defaultBorder,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: cubit.getChangeKmErrorText(context, widget.index),
          )
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLastChangedTextFormField(),
            buildChangeIntervalTextFormField(),
          ],
        ),
        const SizedBox(height: 10),
        buildChangeKmTextFormField(),
        const SizedBox(height: 15),
      ],
    );
  }
}
