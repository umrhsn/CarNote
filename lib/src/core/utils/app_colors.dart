import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class AppColors {
  /// Scaffold
  static const Color scaffoldBackgroundLight = Color(0xffffffff);
  static const Color scaffoldBackgroundDark = Color(0xff000000); // 0xff0D1117

  /// Primary
  static const Color primaryLight = Color(0xff1F883D);
  static const Color primaryDark = Color(0xff238636);

  static final MaterialColor _primarySwatchLight = MaterialColor(
    primaryLight.value, //0%
    const <int, Color>{
      50: Color(0xff1f883d), //10%
      100: Color(0xff196d31), //20%
      200: Color(0xff165f2b), //30%
      300: Color(0xff135225), //40%
      400: Color(0xff10441f), //50%
      500: Color(0xff0c3618), //60%
      600: Color(0xff092912), //70%
      700: Color(0xff061b0c), //80%
      800: Color(0xff030e06), //90%
      900: Color(0xff000000), //100%
    },
  );

  static final MaterialColor _primarySwatchDark = MaterialColor(
    primaryDark.value, //0%
    const <int, Color>{
      50: Color(0xff359450), //10%
      100: Color(0xff4ca064), //20%
      200: Color(0xff62ac77), //30%
      300: Color(0xff79b88b), //40%
      400: Color(0xff8fc49e), //50%
      500: Color(0xffa5cfb1), //60%
      600: Color(0xffbcdbc5), //70%
      700: Color(0xffd2e7d8), //80%
      800: Color(0xffe9f3ec), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static const Color boxShadowLight = Colors.grey;
  static const Color boxShadowDark = Colors.black;

  static Color getPrimaryColor(BuildContext context) => context.isLight ? primaryLight : primaryDark;

  static MaterialColor getPrimarySwatchColor({required bool isLight}) => isLight ? _primarySwatchLight : _primarySwatchDark;

  /// Icons
  static const Color iconLight = Color(0xff54AEFF);
  static const Color iconDark = Color(0xff7D8590);

  static Color getIconColor(BuildContext context) => context.isLight ? iconLight : iconDark;

  /// TextFields
  static Color getAppBarTextFieldLabel(BuildContext context) => context.isLight ? Colors.black.withAlpha(70) : Colors.white.withAlpha(80);

  static Color getTextFieldBorderAndLabelFocused(BuildContext context) => context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  static const Color _disabledTextFieldLight = Color(0xffF6F8FA);
  static const Color _disabledTextFieldDark = Color(0xff21262D);
  static final Color textFieldFocusedLight = Colors.orange.shade900;
  static const Color textFieldFocusedDark = Colors.white70;

  static Color getTextFieldBorderAndLabel(BuildContext context) => context.isLight ? hintLight : hintDark;

  static Color getDisabledTextFieldFill(BuildContext context) => context.isLight ? _disabledTextFieldLight : _disabledTextFieldDark;

  static Color getValidatingTextColor(BuildContext context, {required ConsumableCubit cubit, required int index}) => cubit.isNormalText(index)
      ? getHintColor(context)
      : cubit.isWarningText(index)
          ? AppColors.getWarningColor(context)
          : AppColors.getErrorColor(context);

  static Color getLastChangedAndChangeIntervalLabelColorIndexed(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getLastChangedKmValidatingText(context, cubit: cubit, index: index).data != ''
          ? getErrorColor(context)
          : cubit.lastChangedAtFocuses[index].hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getLastChangedAndChangeIntervalLabelColor(BuildContext context, {required ConsumableCubit cubit}) =>
      cubit.getAddLastChangedKmValidatingText(context).data != ''
          ? getErrorColor(context)
          : cubit.lastChangedFocus.hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getRemainingKmLabelColor(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getRemainingKmValidatingText(context, cubit: cubit, index: index).data != ''
          ? getValidatingTextColor(context, cubit: cubit, index: index)
          : cubit.remainingKmFocuses[index].hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getChangeIntervalLabelColorIndexed(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      cubit.changeIntervalFocuses[index].hasFocus ? getTextFieldBorderAndLabelFocused(context) : getTextFieldBorderAndLabel(context);

  static Color getChangeIntervalLabelColor(BuildContext context, {required ConsumableCubit cubit}) =>
      cubit.changeIntervalFocus.hasFocus ? getTextFieldBorderAndLabelFocused(context) : getTextFieldBorderAndLabel(context);

  /// Buttons
  static final Color _btnDisabledLight = Colors.grey.withAlpha(100);
  static final Color _btnDisabledDark = Colors.white.withAlpha(70);

  static Color getBtnDisabledForeground(BuildContext context) => context.isLight ? scaffoldBackgroundLight : scaffoldBackgroundLight.withAlpha(60);

  static Color getBtnDisabledBackground(BuildContext context) => context.isLight ? _btnDisabledLight : _btnDisabledDark;

  /// Texts
  static const Color errorLight = Color(0xffb00020);
  static const Color errorDark = Color(0xffcf6679);

  static const Color _warningLight = Color(0xffd4ad00); // old: 0xffd40000
  static const Color _warningDark = Color(0xfffff694); // old: 0xffff9494

  static const Color hintLight = Color(0xff656D76); // 0xff656D76
  static const Color hintDark = Color(0xff7C848F);

  static Color getWarningColor(BuildContext context) => context.isLight ? _warningLight : _warningDark;

  static Color getErrorColor(BuildContext context) => context.isLight ? errorLight : errorDark;

  static Color getNormalTextColor(BuildContext context) => Theme.of(context).colorScheme.onBackground;

  static Color getHintColor(BuildContext context) => context.isLight ? hintLight : hintDark;

  /// Cards
  static const Color cardLight = Color(0xffF6F8FA);
  static const Color cardDark = Color(0xff21262D);

  static const Color _cardErrorLight = Color(0xfffff3f5);
  static const Color _cardErrorDark = Color(0xff2c161c);

  static const Color _cardWarningLight = Color(0xfffffae9);
  static const Color _cardWarningDark = Color(0xff2f2e1b);

  static Color getCardNormalColor(BuildContext context) => context.isLight ? cardLight : cardDark;

  static Color getCardErrorColor(BuildContext context) => context.isLight ? _cardErrorLight : _cardErrorDark;

  static Color getCardConsumableItemColor(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      cubit.isNormalText(index) ? getCardNormalColor(context) : _getCardConsumableItemAbnormalColor(context, cubit: cubit, index: index);

  static Color _getCardConsumableItemAbnormalColor(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      cubit.isErrorText(index) || cubit.isConsiderText(index)
          ? _getCardConsumableItemErrorColor(context, cubit: cubit, index: index)
          : _getCardWarningColor(context, cubit: cubit, index: index);

  static Color _getCardConsumableItemErrorColor(BuildContext context, {required ConsumableCubit cubit, required int index}) =>
      cubit.isErrorText(index) || cubit.isConsiderText(index)
          ? context.isLight
              ? _cardErrorLight
              : _cardErrorDark
          : getCardNormalColor(context);

  static Color _getCardWarningColor(BuildContext context, {required ConsumableCubit cubit, required int index}) => cubit.isWarningText(index)
      ? context.isLight
          ? _cardWarningLight
          : _cardWarningDark
      : getCardNormalColor(context);
}
