import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/extensions/media_query_values.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
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

    TextFormField buildAppBarTextFormField() {
      return TextFormField(
        focusNode: cubit.currentKmFocus,
        cursorColor: AppColors.getAppBarTextFieldBorderAndLabelFocused(context),
        controller: cubit.currentKmController,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          fillColor: context.isLight
              ? AppColors.appBarTextFieldFillLight
              : AppColors.appBarTextFieldFillDark,
          floatingLabelStyle: TextStyle(
            color: cubit.currentKmFocus.hasFocus
                ? AppColors.getAppBarTextFieldBorderAndLabelFocused(context)
                : AppColors.getAppBarTextFieldBorderAndLabel(context),
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.getAppBarTextFieldBorderAndLabel(context))),
          labelText: AppStrings.currentKmLabel,
          labelStyle: TextStyle(
              color: context.isLight ? Colors.black.withAlpha(70) : Colors.white.withAlpha(80)),
        ),
        inputFormatters: [
          ThousandSeparatorTextInputFormatter(),
          LengthLimitingTextInputFormatter(9),
        ],
        onChanged: (_) {
          cubit.validateAllLastChangedKilometerFields();
          cubit.validateAllChangeKilometerFields();
        },
        onEditingComplete: () => cubit.validateAllChangeKilometerFields(),
        autovalidateMode: AutovalidateMode.always,
      );
    }

    Expanded buildConsumablesList() {
      return Expanded(
        flex: 100,
        child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ListView.separated(
              itemCount: AppStrings.consumables.length,
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
          onPressed: () {},
        ),
      );
    }

    return BlocBuilder<ConsumablesCubit, ConsumablesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.isLight ? AppColors.primaryLight : AppColors.primaryDark,
            toolbarHeight: 100,
            title: buildAppBarTextFormField(),
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
