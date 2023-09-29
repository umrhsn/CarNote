import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/text_fields/consumable_name_text_field.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/change_interval_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/last_changed_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/remaining_kilometer_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ConsumableItemWidget extends StatefulWidget {
  final int index;
  final String name;

  const ConsumableItemWidget({Key? key, required this.index, required this.name}) : super(key: key);

  @override
  State<ConsumableItemWidget> createState() => ConsumableItemWidgetState();
}

class ConsumableItemWidgetState extends State<ConsumableItemWidget> {
  late ConsumableCubit _cubit;
  bool _editing = false;

  @override
  void initState() {
    _cubit = ConsumableCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool visible = di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolDetailedModeOn) ?? true;

    _cubit.calculateRemainingKmAndCurrentKmDifference(widget.index);
    _cubit.calculateWarningDifference(widget.index);
    _cubit.getRemainingKm(widget.index);

    return Card(
      color: _cubit.getLastChangedKmValidatingText(context, widget.index).data != ''
          ? AppColors.getCardErrorColor(context)
          : AppColors.getCardConsumableItemColor(context, cubit: _cubit, index: widget.index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.edge10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                  top: AppDimens.edge20, bottom: AppDimens.edge10, start: AppDimens.edge10),
              child: Row(
                children: [
                  !_editing
                      ? Expanded(
                          flex: AppDimens.flex30,
                          child: Text(
                            widget.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: AppDimens.fontSize15),
                          ),
                        )
                      : Expanded(child: ConsumableNameTextField(index: widget.index)),
                  !_editing ? const Spacer() : SizedBox(width: AppDimens.sizedBox30),
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
                          onPressed: () => DialogHelper.showRemoveConsumableConfirmationDialog(
                              context, widget.index),
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
                padding: EdgeInsets.symmetric(horizontal: AppDimens.edge10),
                child: Column(
                  children: [
                    SizedBox(height: AppDimens.sizedBox10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LastChangedTextFormField(cubit: _cubit, index: widget.index),
                        ChangeIntervalTextFormField(cubit: _cubit, index: widget.index),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimens.sizedBox10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.edge10),
              child: RemainingKilometerTextFormField(cubit: _cubit, index: widget.index),
            ),
            SizedBox(height: AppDimens.sizedBox20),
          ],
        ),
      ),
    );
  }
}
