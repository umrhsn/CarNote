import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
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
    cubit.calculateWarningDifference(widget.index);
    cubit.getChangeKilometer(widget.index);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? cubit.getValidatingTextColor(context, widget.index)
            : cubit.lastChangedAtFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    Color getChangeKmLabelColor() =>
        cubit.getChangeKmValidatingText(context, widget.index).data != ''
            ? cubit.getValidatingTextColor(context, widget.index)
            : cubit.changeKmFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

    Color getChangeIntervalLabelColor() => cubit.changeIntervalFocuses[widget.index].hasFocus
        ? AppColors.getTextFieldBorderAndLabelFocused(context)
        : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getChangeKmDisabledBorder() =>
        cubit.getChangeKmValidatingText(context, widget.index).data != '' &&
                !cubit.isNormalText(widget.index)
            ? cubit.isWarningText(widget.index)
                ? cubit.getWarningBorder(context)
                : cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

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
              child: cubit.getLastChangedKmValidatingText(context, widget.index),
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

    Column buildChangeKmTextFormField(BuildContext context) {
      return Column(
        children: [
          TextFormField(
            enabled: false,
            controller: cubit.changeKmControllers[widget.index],
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              labelText: AppStrings.changeKmLabel,
              fillColor: AppColors.getChangeKmFillColor(context),
              floatingLabelStyle:
                  TextStyle(color: getChangeKmLabelColor(), fontWeight: FontWeight.bold),
              disabledBorder: getChangeKmDisabledBorder(),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: cubit.getChangeKmValidatingText(context, widget.index),
          )
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Row(
            children: [
              Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Icon(Icons.visibility, color: Colors.white.withAlpha(90)),
            ],
          ),
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
        buildChangeKmTextFormField(context),
        const SizedBox(height: 15),
      ],
    );
  }
}
