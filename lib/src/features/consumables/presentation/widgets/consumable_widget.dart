import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/consumable_name_text_field.dart';
import 'package:car_note/src/core/widgets/dialogs.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:car_note/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

class ConsumableWidget extends StatefulWidget {
  final int index;
  final String name;

  const ConsumableWidget({Key? key, required this.index, required this.name}) : super(key: key);

  @override
  State<ConsumableWidget> createState() => ConsumableWidgetState();
}

class ConsumableWidgetState extends State<ConsumableWidget> {
  bool _editing = false;

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConsumableCubit cubit = ConsumableCubit.get(context);
    bool visible = di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;

    cubit.calculateRemainingKmAndCurrentKmDifference(widget.index);
    cubit.calculateWarningDifference(widget.index);
    cubit.getRemainingKm(widget.index);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? AppColors.getErrorColor(context)
            : cubit.lastChangedAtFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    Color getRemainingKmLabelColor() =>
        cubit.getRemainingKmValidatingText(context, widget.index).data != ''
            ? cubit.getValidatingTextColor(context, widget.index)
            : cubit.remainingKmFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

    Color getChangeIntervalLabelColor() => cubit.changeIntervalFocuses[widget.index].hasFocus
        ? AppColors.getTextFieldBorderAndLabelFocused(context)
        : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getRemainingKmDisabledBorder() =>
        cubit.getRemainingKmValidatingText(context, widget.index).data != '' &&
                !cubit.isNormalText(widget.index)
            ? cubit.isWarningText(widget.index)
                ? cubit.getWarningBorder(context)
                : cubit.getErrorBorder(context)
            : cubit.getDefaultBorder(context);

    Expanded buildLastChangedTextFormField() {
      return Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: TextFormField(
                controller: cubit.lastChangedAtControllers[widget.index],
                focusNode: cubit.lastChangedAtFocuses[widget.index],
                cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
                onChanged: (_) => cubit.getRemainingKm(widget.index),
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
                  LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandSeparatorInputFormatter(),
                ],
                style: TextStyle(fontFamily: AppStrings.fontFamily),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: cubit.getLastChangedKmValidatingText(context, widget.index),
            ),
          ],
        ),
      );
    }

    Expanded buildChangeIntervalTextFormField() {
      return Expanded(
        child: TextFormField(
          controller: cubit.changeIntervalControllers[widget.index],
          focusNode: cubit.changeIntervalFocuses[widget.index],
          cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
          onChanged: (_) => cubit.getRemainingKm(widget.index),
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
            LengthLimitingTextInputFormatter(7),
            FilteringTextInputFormatter.digitsOnly,
            ThousandSeparatorInputFormatter(),
          ],
          style: TextStyle(fontFamily: AppStrings.fontFamily),
        ),
      );
    }

    Column buildRemainingKmTextFormField(BuildContext context) {
      return Column(
        children: [
          TextFormField(
            enabled: false,
            controller: cubit.remainingKmControllers[widget.index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.getNormalTextColor(context),
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: cubit.isErrorText(widget.index)
                  ? AppStrings.remainingKmErrorLabel(context)
                  : AppStrings.remainingKmNormalWarningLabel(context),
              fillColor: AppColors.getDisabledTextFieldFill(context),
              floatingLabelStyle:
                  TextStyle(color: getRemainingKmLabelColor(), fontWeight: FontWeight.bold),
              disabledBorder: getRemainingKmDisabledBorder(),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: cubit.getRemainingKmValidatingText(context, widget.index),
          )
        ],
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 20, bottom: 10, start: 10),
              child: Row(
                children: [
                  !_editing
                      ? Expanded(
                          flex: 30,
                          child: Text(
                            widget.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        )
                      : Expanded(child: ConsumableNameTextField(index: widget.index)),
                  !_editing ? const Spacer() : const SizedBox(width: 30),
                  Visibility(
                    visible: visible,
                    child: Row(
                      children: [
                        _editing
                            ? IconButton(
                                onPressed: () {
                                  DatabaseHelper.writeConsumableName(context, widget.index)
                                      .then((value) {
                                    if (value) {
                                      setState(() => _editing = false);
                                      cubit.consumableNameController.text = '';
                                    } else {
                                      BotToast.showText(text: AppStrings.nameNotEmpty(context));
                                    }
                                  });
                                },
                                icon: const Icon(Icons.check))
                            : const SizedBox(),
                        _editing
                            ? IconButton(
                                onPressed: () {
                                  cubit.consumableNameController.text = '';
                                  setState(() => _editing = false);
                                },
                                icon: const Icon(Icons.close))
                            : const SizedBox(),
                        !_editing
                            ? IconButton(
                                onPressed: () {
                                  cubit.consumableNameController.text = '';
                                  setState(() => _editing = true);
                                },
                                icon: const Icon(Icons.edit))
                            : const SizedBox(),
                        IconButton(
                            onPressed: () => Dialogs.showRemoveConsumableConfirmationDialog(
                                context, widget.index),
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: visible,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: buildRemainingKmTextFormField(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
