import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/consumables_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsumableWidget extends StatefulWidget {
  final String name;
  final TextEditingController lastChangedAtController;
  final TextEditingController changeIntervalController;
  final TextEditingController changeKmController;

  const ConsumableWidget({
    Key? key,
    required this.name,
    required this.lastChangedAtController,
    required this.changeIntervalController,
    required this.changeKmController,
  }) : super(key: key);

  @override
  State<ConsumableWidget> createState() => ConsumableWidgetState();
}

class ConsumableWidgetState extends State<ConsumableWidget> {
  @override
  Widget build(BuildContext context) {
    ConsumablesCubit cubit = ConsumablesCubit.get(context);

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
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  // TODO: last changed should not exceed current km
                  child: TextFormField(
                    controller: widget.lastChangedAtController,
                    onChanged: (_) => cubit.getChangeKilometer(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: AppStrings.lastChangedAtLabel),
                    inputFormatters: [
                      ThousandSeparatorTextInputFormatter(),
                      LengthLimitingTextInputFormatter(8),
                    ],
                  ),
                )),
                Flexible(
                    child: TextFormField(
                  controller: widget.changeIntervalController,
                  onChanged: (_) => cubit.getChangeKilometer(),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: AppStrings.changeIntervalLabel),
                  inputFormatters: [
                    ThousandSeparatorTextInputFormatter(),
                    LengthLimitingTextInputFormatter(7),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 8),
            // TODO: change km should give an alarm to the user if it exceeded current km
            TextFormField(
              enabled: false,
              controller: widget.changeKmController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: AppStrings.changeKmLabel,
                fillColor: AppColors.primaryLight.withAlpha(20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
