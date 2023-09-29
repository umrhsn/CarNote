import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/consumable_name_text_field.dart';
import 'package:car_note/src/core/widgets/buttons/custom_button.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddConsumableScreen extends StatefulWidget {
  const AddConsumableScreen({Key? key}) : super(key: key);

  @override
  State<AddConsumableScreen> createState() => AddConsumableScreenState();
}

class AddConsumableScreenState extends State<AddConsumableScreen> {
  void _resetControllersValues() {
    ConsumableCubit cubit = ConsumableCubit.get(context);
    cubit.consumableNameController.text = '';
    cubit.lastChangedController.text = '';
    cubit.changeIntervalController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
            ? AppColors.getErrorColor(context)
            : cubit.lastChangedFocus.hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        cubit.getAddLastChangedKmValidatingText(context).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

    Color getChangeIntervalLabelColor() => cubit.changeIntervalFocus.hasFocus
        ? AppColors.getTextFieldBorderAndLabelFocused(context)
        : AppColors.getTextFieldBorderAndLabel(context);

    Expanded buildLastChangedTextFormField() {
      return Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(end: AppDimens.edge8),
              child: TextFormField(
                controller: cubit.lastChangedController,
                focusNode: cubit.lastChangedFocus,
                cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
                onChanged: (_) => cubit.getAddLastChangedKmValidatingText(context),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: AppStrings.lastChangedAtLabel(context),
                  floatingLabelStyle: TextStyle(
                    color: getLastChangedAndChangeIntervalLabelColor(),
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: getLastChangedAndChangeIntervalFocusedBorder(),
                  enabledBorder: getLastChangedAndChangeIntervalEnabledBorder(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(AppNums.lengthLimit9),
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandSeparatorInputFormatter(),
                ],
                style: TextStyle(fontFamily: AppStrings.fontFamily),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: cubit.getAddLastChangedKmValidatingText(context),
            ),
          ],
        ),
      );
    }

    Expanded buildChangeIntervalTextFormField() {
      return Expanded(
        child: TextFormField(
          controller: cubit.changeIntervalController,
          focusNode: cubit.changeIntervalFocus,
          cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: AppStrings.changeIntervalLabel(context),
            floatingLabelStyle: TextStyle(
              color: getChangeIntervalLabelColor(),
              fontWeight: FontWeight.bold,
            ),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(AppNums.lengthLimit7),
            FilteringTextInputFormatter.digitsOnly,
            ThousandSeparatorInputFormatter(),
          ],
          style: TextStyle(fontFamily: AppStrings.fontFamily),
        ),
      );
    }

    return BlocBuilder<ConsumableCubit, ConsumableState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            _resetControllersValues();
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: AppDimens.appBarHeight80,
              title: Text(
                AppStrings.addConsumable(context),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.edge10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(AppDimens.edge20),
                        child: Column(
                          children: [
                            ConsumableNameTextField(),
                            SizedBox(height: AppDimens.sizedBox20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildLastChangedTextFormField(),
                                buildChangeIntervalTextFormField(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppDimens.edge10),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: AppStrings.btnAddItem(context).toUpperCase(),
                            btnEnabled: cubit.shouldEnableAddButton(context),
                            onPressed: () {
                              DatabaseHelper.addConsumable(
                                context,
                                name: cubit.consumableNameController.text,
                                lastChangedAt: cubit.lastChangedController.text.isEmpty
                                    ? 0
                                    : int.parse(
                                        cubit.lastChangedController.text.removeThousandSeparator()),
                                changeInterval: cubit.changeIntervalController.text.isEmpty
                                    ? 0
                                    : int.parse(cubit.changeIntervalController.text
                                        .removeThousandSeparator()),
                              ).then((value) {
                                if (value) {
                                  BotToast.showText(text: AppStrings.itemAdded(context));
                                  Navigator.pop(context);
                                } else {
                                  BotToast.showText(text: AppStrings.invalidInput(context));
                                }
                                _resetControllersValues();
                              });
                            },
                          ),
                        ),
                        SizedBox(width: AppDimens.sizedBox10),
                        Expanded(
                          child: CustomButton(
                            text: AppStrings.cancel(context).toUpperCase(),
                            onPressed: () {
                              Navigator.pop(context);
                              _resetControllersValues();
                            },
                            btnEnabled: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimens.sizedBox15),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15),
                  //   child: AdmobBanner(
                  //     adUnitId: AdServices.getBannerAdUnitId(),
                  //     adSize: AdmobBannerSize.ADAPTIVE_BANNER(width: context.width.toInt()),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
