import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConsumableWidget extends StatefulWidget {
  final String name;
  final TextEditingController currentKmController;

  const ConsumableWidget({Key? key, required this.name, required this.currentKmController})
      : super(key: key);

  @override
  State<ConsumableWidget> createState() => ConsumableWidgetState();
}

class ConsumableWidgetState extends State<ConsumableWidget> {
  final TextEditingController changeIntervalController = TextEditingController();
  final TextEditingController changeKmController = TextEditingController();

  void _getChangeKilometer() {
    setState(() {
      changeKmController.text =
          _sumChangeKilometer() != 0 ? _sumChangeKilometer().toThousands() : '';
    });
  }

  int _sumChangeKilometer() {
    if (widget.currentKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      return int.parse(widget.currentKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: changeIntervalController,
                onChanged: (_) => _getChangeKilometer(),
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
                controller: changeKmController,
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
