import 'dart:io';

import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_widget.dart';
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
    ConsumableCubit cubit = ConsumableCubit.get(context);

    Future<bool> onWillPop() async {
      for (int index = 0; index < Consumable.getCount(); index++) {
        Car? car = CarCubit.carBox.get(AppStrings.carBox);
        Consumable? consumable = ConsumableCubit.consumableBox.get(index);

        if (car != null && consumable != null) {
          bool currentKmHasValue = cubit.currentKmController.text.isNotEmpty && car.currentKm != 0;
          bool lastChangedKmHasValue = cubit.lastChangedAtControllers[index].text.isNotEmpty &&
              consumable.lastChangedAt != 0;
          bool changeIntervalHasValue = cubit.changeIntervalControllers[index].text.isNotEmpty &&
              consumable.changeInterval != 0;
          bool changeKmHasValue =
              cubit.changeKmControllers[index].text.isNotEmpty && consumable.changeKm != 0;

          bool currentKmMatch =
              car.currentKm.toString() == cubit.currentKmController.text.removeThousandSeparator();
          bool lastChangedKmMatch = consumable.lastChangedAt.toString() ==
              cubit.lastChangedAtControllers[index].text.removeThousandSeparator();
          bool changeIntervalMatch = consumable.changeInterval.toString() ==
              cubit.changeIntervalControllers[index].text.removeThousandSeparator();
          bool changeKmMatch = consumable.changeKm.toString() ==
              cubit.changeKmControllers[index].text.removeThousandSeparator();

          if (currentKmHasValue &&
              lastChangedKmHasValue &&
              changeIntervalHasValue &&
              changeKmHasValue) {
            if (!currentKmMatch || !lastChangedKmMatch || !changeIntervalMatch || !changeKmMatch) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(Icons.warning_rounded, color: Colors.red, size: 50),
                  title: const Text(AppStrings.changedDataMsg),
                  content: const Text(AppStrings.sureToExitMsg),
                  actions: [
                    TextButton(
                      onPressed: () =>
                          Future.sync(() => cubit.writeData()).then((value) => exit(0)),
                      child: Text(
                        AppStrings.saveData.toUpperCase(),
                        style: TextStyle(
                            color: context.isLight
                                ? AppColors.primarySwatchLight.shade100
                                : AppColors.primarySwatchDark.shade500),
                      ),
                    ),
                    TextButton(
                      onPressed: () => exit(0),
                      child: Text(
                        AppStrings.exitWithoutSaving.toUpperCase(),
                        style: TextStyle(
                            color: context.isLight
                                ? AppColors.primarySwatchLight.shade100
                                : AppColors.primarySwatchDark.shade500),
                      ),
                    ),
                  ],
                ),
              );
              return false;
            }
          }
        }
      }
      return true;
    }

    Column buildAppBarWidgets() {
      return Column(
        children: [
          // TODO: add granular visibility to consumable widget
          IconButton(
            icon: Icon(cubit.visible ? Icons.visibility_off : Icons.visibility, size: 20),
            onPressed: () => setState(() => cubit.visible = !cubit.visible),
          ),
          TextFormField(
            focusNode: cubit.currentKmFocus,
            cursorColor: AppColors.getAppBarTextFieldBorderAndLabelFocused(context),
            controller: cubit.currentKmController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              fillColor: AppColors.getAppBarTextFieldFill(context),
              floatingLabelStyle: TextStyle(
                color: cubit.currentKmFocus.hasFocus
                    ? AppColors.getAppBarTextFieldBorderAndLabelFocused(context)
                    : AppColors.getAppBarTextFieldBorderAndLabel(context),
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.getAppBarTextFieldBorderAndLabel(context),
                ),
              ),
              labelText: AppStrings.currentKmLabel,
              labelStyle: TextStyle(color: AppColors.getAppBarTextFieldLabel(context)),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(9),
              FilteringTextInputFormatter.digitsOnly,
              ThousandSeparatorInputFormatter(),
            ],
            onChanged: (_) {
              cubit.validateAllLastChangedKilometerFields();
              cubit.validateAllChangeKilometerFields(context);
            },
            onEditingComplete: () => cubit.validateAllChangeKilometerFields(context),
            autovalidateMode: AutovalidateMode.always,
          ),
        ],
      );
    }

    Expanded buildConsumablesList() {
      return Expanded(
        flex: 100,
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ListView.separated(
              itemCount: Consumable.getCount(),
              itemBuilder: (context, index) => ConsumableWidget(
                  index: index, name: AppStrings.consumables[index], visible: cubit.visible),
              separatorBuilder: (context, index) => const Divider(thickness: 2),
            ),
          ),
        ),
      );
    }

    Padding buildSaveButton() {
      return Padding(
        padding: const EdgeInsets.only(top: 10, right: 15),
        child: CustomButton(
          text: AppStrings.btnSave.toUpperCase(),
          btnEnabled: cubit.shouldEnableSaveButton(context),
          onPressed: () => cubit.writeData(),
        ),
      );
    }

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.getPrimaryColor(context),
              toolbarHeight: 140,
              title: buildAppBarWidgets(),
            ),
            extendBody: true,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildConsumablesList(),
                    const Spacer(),
                    buildSaveButton(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
