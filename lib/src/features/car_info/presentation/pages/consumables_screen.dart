import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
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
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 8.5),
          child: BlocBuilder<ConsumablesCubit, ConsumablesState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    cursorColor: context.isLight ? AppColors.primaryLight : AppColors.primaryDark,
                    controller: cubit.currentKmController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      labelText: AppStrings.currentKmLabel,
                      fillColor: context.isLight
                          ? AppColors.primaryLight.withAlpha(50)
                          : AppColors.primaryDark.withAlpha(50),
                    ),
                    inputFormatters: [
                      ThousandSeparatorTextInputFormatter(),
                      LengthLimitingTextInputFormatter(9),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 2),
                  Expanded(
                    flex: 100,
                    child: Scrollbar(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ListView.separated(
                          itemCount: AppStrings.consumables.length,
                          itemBuilder: (context, index) {
                            return ConsumableWidget(
                              name: AppStrings.consumables[index],
                              lastChangedAtController: cubit.lastChangedAtControllers[index],
                              changeIntervalController: cubit.changeIntervalControllers[index],
                              changeKmController: cubit.changeKmControllers[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(thickness: 2);
                          },
                        ),
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
