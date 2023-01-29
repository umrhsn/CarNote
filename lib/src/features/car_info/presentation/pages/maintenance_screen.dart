import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/consumable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final TextEditingController _currentKmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _currentKmController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: AppStrings.currentKmHint),
                // TODO: need to add onChanged here without repeating the code inside ChangeableWidget
                inputFormatters: [
                  ThousandSeparatorTextInputFormatter(),
                  LengthLimitingTextInputFormatter(9),
                ],
              ),
              SizedBox(height: 5),
              Spacer(),
              Flexible(
                flex: 100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ConsumableWidget(
                        name: AppStrings.consumable1,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable2,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable3,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable4,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable5,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable6,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable7,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable8,
                        currentKmController: _currentKmController,
                      ),
                      ConsumableWidget(
                        name: AppStrings.consumable9,
                        currentKmController: _currentKmController,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Text(AppStrings.btnSave.toUpperCase()))
            ],
          ),
        ),
      ),
    );
  }
}
