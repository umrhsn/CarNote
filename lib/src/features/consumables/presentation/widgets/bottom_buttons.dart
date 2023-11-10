import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button_with_icon.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomButtons extends StatelessWidget {
  BottomButtons({
    super.key,
    required this.consumableCubit,
  });

  final ConsumableCubit consumableCubit;
  List? _list;

  @override
  Widget build(BuildContext context) {
    _list = DatabaseHelper.consumableBox.get(AppKeys.consumableBox);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
      child: Row(
        children: [
          Expanded(
            key: AppKeys.keySaveData,
            child: AnimatedButton(
              text: AppStrings.btnSave(context),
              btnEnabled: consumableCubit.shouldEnableButtons(context) && _list!.isNotEmpty,
              onPressed: () =>
                  DatabaseHelper.writeConsumablesData(context).then((value) => BotToast.showText(text: AppStrings.dataSavedSuccessfully(context))),
            ),
          ),
          const SizedBox(width: AppDimens.sizedBox10),
          AnimatedButtonWithIcon(
            key: AppKeys.keyAddItem,
            icon: Icons.add,
            btnEnabled: consumableCubit.shouldEnableButtons(context),
            onPressed: () => Navigator.pushNamed(context, Routes.addConsumableRoute),
          ),
        ],
      ),
    );
  }
}
