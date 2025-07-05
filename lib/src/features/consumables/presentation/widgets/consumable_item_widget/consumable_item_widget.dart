// lib/src/features/consumables/presentation/widgets/consumable_item_widget/consumable_item_widget.dart
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/core/widgets/text_fields/consumable_name_text_field.dart';
import 'package:car_note/src/core/services/dialogs/dialog_helper.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/change_interval_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/last_changed_text_form_field.dart';
import 'package:car_note/src/features/consumables/presentation/widgets/consumable_item_widget/remaining_kilometer_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ConsumableItemWidget extends StatefulWidget {
  final int index;
  final String name;
  final ConsumableCubit consumableCubit;

  const ConsumableItemWidget({
    super.key,
    required this.index,
    required this.name,
    required this.consumableCubit,
  });

  @override
  State<ConsumableItemWidget> createState() => ConsumableItemWidgetState();
}

class ConsumableItemWidgetState extends State<ConsumableItemWidget> {
  bool _editing = false;

  @override
  Widget build(BuildContext context) {
    bool visible =
        di.sl<SharedPreferences>().getBool(AppKeys.prefsBoolDetailedModeOn) ??
            true;

    widget.consumableCubit
        .calculateRemainingKmAndCurrentKmDifference(widget.index);
    widget.consumableCubit.calculateWarningDifference(widget.index);
    widget.consumableCubit.getRemainingKm(widget.index);

    return Padding(
      padding: EdgeInsets.only(
          bottom: widget.index != (widget.consumableCubit.consumableCount - 1)
              ? AppDimens.padding5
              : 0),
      child: Card(
        color: AppTexts.getLastChangedKmValidatingText(context,
                        cubit: widget.consumableCubit, index: widget.index)
                    .data !=
                ''
            ? AppColors.getCardErrorColor(context)
            : AppColors.getCardConsumableItemColor(context,
                cubit: widget.consumableCubit, index: widget.index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: AppDimens.padding20,
                    bottom: AppDimens.padding8,
                    start: AppDimens.padding10),
                child: Row(
                  children: [
                    !_editing
                        ? Expanded(
                            flex: AppDimens.flex30,
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                widget.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimens.fontSize15),
                              ),
                            ),
                          )
                        : Expanded(
                            child:
                                ConsumableNameTextField(index: widget.index)),
                    !_editing
                        ? const Spacer()
                        : const SizedBox(width: AppDimens.sizedBox30),
                    SizedBox(
                      width: 35.r,
                      child: Visibility(
                        visible: _editing,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: IconButton(
                                  onPressed: () async {
                                    final success = await widget.consumableCubit
                                        .updateConsumableName(
                                            context, widget.index);
                                    if (success) {
                                      setState(() => _editing = false);
                                      widget.consumableCubit
                                          .consumableNameController.text = '';
                                    } else {
                                      BotToast.showText(
                                          text:
                                              AppStrings.nameNotEmpty(context));
                                    }
                                  },
                                  icon: const Icon(Icons.check)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visible,
                      child: SizedBox(
                        width: 110.r,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _editing
                                ? Flexible(
                                    child: IconButton(
                                        onPressed: () {
                                          widget
                                              .consumableCubit
                                              .consumableNameController
                                              .text = '';
                                          setState(() => _editing = false);
                                        },
                                        icon: const Icon(Icons.close)),
                                  )
                                : const SizedBox(),
                            !_editing
                                ? Flexible(
                                    child: IconButton(
                                        onPressed: () {
                                          widget
                                              .consumableCubit
                                              .consumableNameController
                                              .text = '';
                                          setState(() => _editing = true);
                                        },
                                        icon: Icon(Icons.edit,
                                            key: widget.index == 0
                                                ? AppKeys.keyEditName
                                                : null)),
                                  )
                                : const SizedBox(),
                            Flexible(
                              child: IconButton(
                                onPressed: () => DialogHelper
                                    .showResetConsumableConfirmationDialog(
                                        context,
                                        widget.index,
                                        widget.consumableCubit),
                                icon: Icon(
                                  MdiIcons.restore,
                                  key: widget.index == 0
                                      ? AppKeys.keyResetCard
                                      : null,
                                ),
                              ),
                            ),
                            Flexible(
                              child: IconButton(
                                onPressed: () => DialogHelper
                                    .showRemoveConsumableConfirmationDialog(
                                        context,
                                        widget.index,
                                        widget.consumableCubit),
                                icon: Icon(
                                  MdiIcons.deleteForever,
                                  key: widget.index == 0
                                      ? AppKeys.keyRemoveCard
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: visible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.padding10),
                  child: Column(
                    children: [
                      const SizedBox(height: AppDimens.sizedBox10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LastChangedTextFormField(
                              cubit: widget.consumableCubit,
                              index: widget.index),
                          ChangeIntervalTextFormField(
                              cubit: widget.consumableCubit,
                              index: widget.index),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.sizedBox8),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
                child: RemainingKilometerTextFormField(
                    cubit: widget.consumableCubit, index: widget.index),
              ),
              const SizedBox(height: AppDimens.sizedBox20),
            ],
          ),
        ),
      ),
    );
  }
}
