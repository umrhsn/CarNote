import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/consumables_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsumableWidget extends StatefulWidget {
  final String name;
  final TextEditingController changeIntervalController;
  final TextEditingController changeKmController;

  const ConsumableWidget({
    Key? key,
    required this.name,
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
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextFormField(
                controller: widget.changeIntervalController,
                onChanged: (_) => cubit.getChangeKilometer(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: AppStrings.changeIntervalHint),
                inputFormatters: [
                  ThousandSeparatorTextInputFormatter(),
                  LengthLimitingTextInputFormatter(5),
                ],
              ),
            )),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: TextFormField(
                enabled: false,
                controller: widget.changeKmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppStrings.changeKmHint,
                  fillColor: AppColors.primaryLight.withAlpha(20),
                ),
              ),
            )),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
