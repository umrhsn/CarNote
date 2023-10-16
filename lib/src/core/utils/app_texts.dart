import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class AppTexts {
  /// Error and warning Text widgets
  static Text getCurrentKmValidatingText(BuildContext context, {required ConsumableCubit cubit}) => Text(
        cubit.validateCurrentKilometer(context) ?? '',
        style: TextStyle(
          color: AppColors.getErrorColor(context),
          height: cubit.validateCurrentKilometer(context) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  static Text getLastChangedKmValidatingText(BuildContext context, {required ConsumableCubit cubit, required int index}) => Text(
        cubit.validateLastChangedKilometer(index, context) ?? '',
        style: TextStyle(
          color: AppColors.getErrorColor(context),
          height: cubit.validateLastChangedKilometer(index, context) != null ? 2 : 0,
          fontSize: 11,
        ),
      );

  static Text getRemainingKmValidatingText(BuildContext context, {required ConsumableCubit cubit, required int index}) => Text(
        cubit.validateRemainingKilometer(index, context) ?? '',
        style: TextStyle(
          fontFamily: AppStrings.fontFamily,
          color: AppColors.getValidatingTextColor(context, cubit: cubit, index: index),
          height: cubit.validateRemainingKilometer(index, context) != '' ? 2 : 0,
          fontSize: 11,
        ),
      );
}
