import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
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

    Column buildAppBarWidgets() {
      return Column(
        children: [
          const Icon(Icons.visibility),
          const SizedBox(height: 10),
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
              itemBuilder: (context, index) =>
                  ConsumableWidget(index: index, name: AppStrings.consumables[index]),
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
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.getPrimaryColor(context),
            toolbarHeight: 120,
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
        );
      },
    );
  }
}
