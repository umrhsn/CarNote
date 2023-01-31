import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/consumables_cubit.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/consumable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConsumablesScreen extends StatefulWidget {
  const ConsumablesScreen({Key? key}) : super(key: key);

  @override
  State<ConsumablesScreen> createState() => _ConsumablesScreenState();
}

class _ConsumablesScreenState extends State<ConsumablesScreen> {
  @override
  Widget build(BuildContext context) {
    ConsumablesCubit cubit = ConsumablesCubit.get(context);

    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<ConsumablesCubit, ConsumablesState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: cubit.currentKmController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: AppStrings.currentKmHint),
                    // TODO: need to add onChanged here without repeating the code inside ChangeableWidget
                    inputFormatters: [
                      ThousandSeparatorTextInputFormatter(),
                      LengthLimitingTextInputFormatter(9),
                    ],
                    onChanged: (_) => cubit.getChangeKilometer(),
                  ),
                  const SizedBox(height: 5),
                  const Spacer(),
                  Flexible(
                    flex: 100,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ConsumableWidget(
                            name: AppStrings.consumable1,
                            changeIntervalController: cubit.changeInterval1Controller,
                            changeKmController: cubit.changeKm1Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable2,
                            changeIntervalController: cubit.changeInterval2Controller,
                            changeKmController: cubit.changeKm2Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable3,
                            changeIntervalController: cubit.changeInterval3Controller,
                            changeKmController: cubit.changeKm3Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable4,
                            changeIntervalController: cubit.changeInterval4Controller,
                            changeKmController: cubit.changeKm4Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable5,
                            changeIntervalController: cubit.changeInterval5Controller,
                            changeKmController: cubit.changeKm5Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable6,
                            changeIntervalController: cubit.changeInterval6Controller,
                            changeKmController: cubit.changeKm6Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable7,
                            changeIntervalController: cubit.changeInterval7Controller,
                            changeKmController: cubit.changeKm7Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable8,
                            changeIntervalController: cubit.changeInterval8Controller,
                            changeKmController: cubit.changeKm8Controller,
                          ),
                          ConsumableWidget(
                            name: AppStrings.consumable9,
                            changeIntervalController: cubit.changeInterval9Controller,
                            changeKmController: cubit.changeKm9Controller,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(onPressed: () {}, child: Text(AppStrings.btnSave.toUpperCase()))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
