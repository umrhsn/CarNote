// lib/src/features/consumables/presentation/widgets/add_consumable_screen_widgets/bottom_buttons_widget.dart
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({
    super.key,
    required this.cubit,
  });

  final ConsumableCubit cubit;

  void _resetControllersValues() {
    cubit.consumableNameController.text = '';
    cubit.lastChangedController.text = '';
    cubit.changeIntervalController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
      child: Row(
        children: [
          Expanded(
            child: AnimatedButton(
              text: AppStrings.btnAddItem(context).toUpperCase(),
              btnEnabled: cubit.shouldEnableAddButton(context),
              onPressed: () async {
                await cubit.addConsumable(
                  context,
                  name: cubit.consumableNameController.text,
                  lastChangedAt: cubit.lastChangedController.text.isEmpty
                      ? 0
                      : int.parse(cubit.lastChangedController.text
                          .removeThousandSeparator()),
                  changeInterval: cubit.changeIntervalController.text.isEmpty
                      ? 0
                      : int.parse(cubit.changeIntervalController.text
                          .removeThousandSeparator()),
                );
                Navigator.pop(context);
                _resetControllersValues();
              },
            ),
          ),
          const SizedBox(width: AppDimens.sizedBox10),
          Expanded(
            child: AnimatedButton(
              text: AppStrings.cancel(context).toUpperCase(),
              onPressed: () {
                Navigator.pop(context);
                _resetControllersValues();
              },
            ),
          ),
        ],
      ),
    );
  }
}
