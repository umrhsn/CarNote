import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class AppInputBorders {
  /// ConsumablesScreen
  static OutlineInputBorder getFocusedBorder(BuildContext context) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getTextFieldBorderAndLabelFocused(context),
          strokeAlign: 0,
          width: 1.2,
        ),
      );

  static OutlineInputBorder getDefaultBorder(BuildContext context) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.getHintColor(context),
          width: 1.2,
          strokeAlign: 0,
        ),
      );

  static OutlineInputBorder getErrorBorder(BuildContext context) =>
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.getErrorColor(context), width: 2));

  static OutlineInputBorder getWarningBorder(BuildContext context) =>
      OutlineInputBorder(borderSide: BorderSide(color: AppColors.getWarningColor(context), width: 2));

  static OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorderIndexed(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getLastChangedKmValidatingText(context, cubit: cubit, index: index).data != '' ? getErrorBorder(context) : getFocusedBorder(context);

  static OutlineInputBorder getLastChangedAndChangeIntervalFocusedBorder(BuildContext context, {required ConsumableCubit cubit}) =>
      cubit.getAddLastChangedKmValidatingText(context).data != '' ? getErrorBorder(context) : getFocusedBorder(context);

  static OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorderIndexed(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getLastChangedKmValidatingText(context, cubit: cubit, index: index).data != '' ? getErrorBorder(context) : getDefaultBorder(context);

  static OutlineInputBorder getLastChangedAndChangeIntervalEnabledBorder(BuildContext context, {required ConsumableCubit cubit}) =>
      cubit.getAddLastChangedKmValidatingText(context).data != '' ? getErrorBorder(context) : getDefaultBorder(context);

  static OutlineInputBorder getRemainingKmDisabledBorder(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getRemainingKmValidatingText(context, cubit: cubit, index: index).data != '' && !cubit.isNormalText(index)
          ? cubit.isWarningText(index)
              ? getWarningBorder(context)
              : getErrorBorder(context)
          : getDefaultBorder(context);
}
