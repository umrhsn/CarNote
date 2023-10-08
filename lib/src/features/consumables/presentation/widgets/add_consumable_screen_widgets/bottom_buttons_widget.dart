import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/database/database_helper.dart';
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
              onPressed: () {
                DatabaseHelper.addConsumable(
                  context,
                  name: cubit.consumableNameController.text,
                  lastChangedAt: cubit.lastChangedController.text.isEmpty ? 0 : int.parse(cubit.lastChangedController.text.removeThousandSeparator()),
                  changeInterval:
                      cubit.changeIntervalController.text.isEmpty ? 0 : int.parse(cubit.changeIntervalController.text.removeThousandSeparator()),
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
