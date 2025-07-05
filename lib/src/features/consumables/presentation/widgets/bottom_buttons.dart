// lib/src/features/consumables/presentation/widgets/bottom_buttons.dart
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button_with_icon.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    super.key,
    required this.consumableCubit,
  });

  final ConsumableCubit consumableCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding10),
      child: Row(
        children: [
          Expanded(
            child: AnimatedButton(
              text: AppStrings.btnSave(context),
              btnEnabled: consumableCubit.shouldEnableButtons(context) &&
                  consumableCubit.consumableCount > 0,
              onPressed: () => consumableCubit.saveConsumablesData(context),
            ),
          ),
          const SizedBox(width: AppDimens.sizedBox10),
          AnimatedButtonWithIcon(
            icon: Icons.add,
            btnEnabled: consumableCubit.shouldEnableButtons(context),
            onPressed: () =>
                Navigator.pushNamed(context, Routes.addConsumableRoute),
          ),
        ],
      ),
    );
  }
}
