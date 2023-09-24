import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/consumable_name_text_field.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ConsumableWidget extends StatefulWidget {
  final int index;
  final String name;

  const ConsumableWidget({Key? key, required this.index, required this.name}) : super(key: key);

  @override
  State<ConsumableWidget> createState() => ConsumableWidgetState();
}

class ConsumableWidgetState extends State<ConsumableWidget> {
  late ConsumableCubit _cubit;
  bool _editing = false;

  @override
  void initState() {
    _cubit = ConsumableCubit.get(context);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool visible = di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;

    _cubit.calculateRemainingKmAndCurrentKmDifference(widget.index);
    _cubit.calculateWarningDifference(widget.index);
    _cubit.getRemainingKm(widget.index);

    Color getLastChangedAndChangeIntervalLabelColor() =>
        _cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? AppColors.getErrorColor(context)
            : _cubit.lastChangedAtFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    Color getRemainingKmLabelColor() =>
        _cubit.getRemainingKmValidatingText(context, widget.index).data != ''
            ? _cubit.getValidatingTextColor(context, widget.index)
            : _cubit.remainingKmFocuses[widget.index].hasFocus
                ? AppColors.getTextFieldBorderAndLabelFocused(context)
                : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder() =>
        _cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? _cubit.getErrorBorder(context)
            : _cubit.getFocusedBorder(context);

    OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder() =>
        _cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
            ? _cubit.getErrorBorder(context)
            : _cubit.getDefaultBorder(context);

    Color getChangeIntervalLabelColor() => _cubit.changeIntervalFocuses[widget.index].hasFocus
        ? AppColors.getTextFieldBorderAndLabelFocused(context)
        : AppColors.getTextFieldBorderAndLabel(context);

    OutlineInputBorder getRemainingKmDisabledBorder() =>
        _cubit.getRemainingKmValidatingText(context, widget.index).data != '' &&
                !_cubit.isNormalText(widget.index)
            ? _cubit.isWarningText(widget.index)
                ? _cubit.getWarningBorder(context)
                : _cubit.getErrorBorder(context)
            : _cubit.getDefaultBorder(context);

    Expanded buildLastChangedTextFormField() {
      return Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: TextFormField(
                key: widget.index == 0 ? AppTourService.keyTextFieldLastChanged : null,
                controller: _cubit.lastChangedAtControllers[widget.index],
                focusNode: _cubit.lastChangedAtFocuses[widget.index],
                cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
                onChanged: (_) => _cubit.getRemainingKm(widget.index),
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
              child: _cubit.getLastChangedKmValidatingText(context, widget.index),
            ),
          ],
        ),
      );
    }

    Expanded buildChangeIntervalTextFormField() {
      return Expanded(
        child: TextFormField(
          key: widget.index == 0 ? AppTourService.keyTextFieldChangeInterval : null,
          controller: _cubit.changeIntervalControllers[widget.index],
          focusNode: _cubit.changeIntervalFocuses[widget.index],
          cursorColor: AppColors.getTextFieldBorderAndLabelFocused(context),
          onChanged: (_) => _cubit.getRemainingKm(widget.index),
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
            key: widget.index == 0 ? AppTourService.keyTextFieldRemaining : null,
            enabled: false,
            controller: _cubit.remainingKmControllers[widget.index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.getNormalTextColor(context),
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              labelText: _cubit.isErrorText(widget.index)
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
            child: _cubit.getRemainingKmValidatingText(context, widget.index),
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
                                      _cubit.consumableNameController.text = '';
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
                                  _cubit.consumableNameController.text = '';
                                  setState(() => _editing = false);
                                },
                                icon: const Icon(Icons.close))
                            : const SizedBox(),
                        !_editing
                            ? IconButton(
                                onPressed: () {
                                  _cubit.consumableNameController.text = '';
                                  setState(() => _editing = true);
                                },
                                icon: Icon(Icons.edit,
                                    key: widget.index == 0 ? AppTourService.keyEditName : null))
                            : const SizedBox(),
                        IconButton(
                          onPressed: () =>
                              DialogHelper.showRemoveConsumableConfirmationDialog(context, widget.index),
                          icon: Icon(
                            Icons.delete,
                            key: widget.index == 0 ? AppTourService.keyDeleteCard : null,
                          ),
                        ),
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
