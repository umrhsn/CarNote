import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_texts.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';

class AppColors {
  /// Scaffold - Updated to match the light gray background from the image
  static const Color scaffoldBackgroundLight = Color(0xffF5F7FA);
  static const Color scaffoldBackgroundDark =
      Color(0xff0F172A); // Modern dark blue-gray

  /// Primary - Updated to match the blue accent color from the image
  static const Color primaryLight = Color(0xff007BFF);
  static const Color primaryDark = Color(0xff4A90E2);

  static final MaterialColor _primarySwatchLight = MaterialColor(
    primaryLight.value, //0%
    const <int, Color>{
      50: Color(0xff007BFF), //10%
      100: Color(0xff0066CC), //20%
      200: Color(0xff0052A3), //30%
      300: Color(0xff003D7A), //40%
      400: Color(0xff002951), //50%
      500: Color(0xff001F3F), //60%
      600: Color(0xff001428), //70%
      700: Color(0xff000A14), //80%
      800: Color(0xff000507), //90%
      900: Color(0xff000000), //100%
    },
  );

  static final MaterialColor _primarySwatchDark = MaterialColor(
    primaryDark.value, //0%
    const <int, Color>{
      50: Color(0xff5C9EE8), //10%
      100: Color(0xff6EABEA), //20%
      200: Color(0xff80B8EC), //30%
      300: Color(0xff92C5EE), //40%
      400: Color(0xffA4D2F0), //50%
      500: Color(0xffB6DFF2), //60%
      600: Color(0xffC8ECF4), //70%
      700: Color(0xffDAF9F6), //80%
      800: Color(0xffECF6F8), //90%
      900: Color(0xffffffff), //100%
    },
  );

  static const Color boxShadowLight = Color(0xffE0E6ED);
  static const Color boxShadowDark = Color(0xff1E293B);

  static Color getPrimaryColor(BuildContext context) =>
      context.isLight ? primaryLight : primaryDark;

  static MaterialColor getPrimarySwatchColor({required bool isLight}) =>
      isLight ? _primarySwatchLight : _primarySwatchDark;

  /// Icons
  static Color icon = getPrimarySwatchColor(isLight: false).shade200;

  static const Color iconButtonLight = Color(0xff6B7280);
  static const Color iconButtonDark = Color(0xff94A3B8);

  static Color getIconColor(BuildContext context) =>
      context.isLight ? iconButtonLight : iconButtonDark;

  /// TextFields
  static Color getAppBarTextFieldLabel(BuildContext context) =>
      context.isLight ? Colors.black.withAlpha(70) : Colors.white.withAlpha(80);

  static Color getTextFieldBorderAndLabelFocused(BuildContext context) =>
      context.isLight ? textFieldFocusedLight : textFieldFocusedDark;

  static const Color _disabledTextFieldLight = Color(0xffF8FAFC);
  static const Color _disabledTextFieldDark = Color(0xff1E293B);
  static final Color textFieldFocusedLight = primaryLight;
  static const Color textFieldFocusedDark = Color(0xff60A5FA);

  static Color getTextFieldBorderAndLabel(BuildContext context) =>
      context.isLight ? hintLight : hintDark;

  static Color getDisabledTextFieldFill(BuildContext context) =>
      context.isLight ? _disabledTextFieldLight : _disabledTextFieldDark;

  static Color getValidatingTextColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.isNormalText(index)
          ? getHintColor(context)
          : cubit.isWarningText(index)
              ? AppColors.getWarningColor(context)
              : AppColors.getErrorColor(context);

  static Color getLastChangedAndChangeIntervalLabelColorIndexed(
          BuildContext context,
          {required ConsumableCubit cubit,
          required int index}) =>
      AppTexts.getLastChangedKmValidatingText(context,
                      cubit: cubit, index: index)
                  .data !=
              ''
          ? getErrorColor(context)
          : cubit.lastChangedAtFocuses[index].hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getLastChangedAndChangeIntervalLabelColor(BuildContext context,
          {required ConsumableCubit cubit}) =>
      cubit.getAddLastChangedKmValidatingText(context).data != ''
          ? getErrorColor(context)
          : cubit.lastChangedFocus.hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getRemainingKmLabelColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      AppTexts.getRemainingKmValidatingText(context, cubit: cubit, index: index)
                  .data !=
              ''
          ? getValidatingTextColor(context, cubit: cubit, index: index)
          : cubit.remainingKmFocuses[index].hasFocus
              ? getTextFieldBorderAndLabelFocused(context)
              : getTextFieldBorderAndLabel(context);

  static Color getChangeIntervalLabelColorIndexed(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.changeIntervalFocuses[index].hasFocus
          ? getTextFieldBorderAndLabelFocused(context)
          : getTextFieldBorderAndLabel(context);

  static Color getChangeIntervalLabelColor(BuildContext context,
          {required ConsumableCubit cubit}) =>
      cubit.changeIntervalFocus.hasFocus
          ? getTextFieldBorderAndLabelFocused(context)
          : getTextFieldBorderAndLabel(context);

  /// Buttons
  static final Color _btnDisabledLight = Color(0xffE5E7EB);
  static final Color _btnDisabledDark = Color(0xff374151);

  static Color getBtnDisabledForeground(BuildContext context) => context.isLight
      ? scaffoldBackgroundLight
      : scaffoldBackgroundLight.withAlpha(60);

  static Color getBtnDisabledBackground(BuildContext context) =>
      context.isLight ? _btnDisabledLight : _btnDisabledDark;

  /// Texts
  static const Color errorLight =
      Color(0xffDC2626); // Updated to match red from image
  static const Color errorDark = Color(0xffF87171);

  static const Color _warningLight =
      Color(0xffF59E0B); // Updated to match orange/yellow from image
  static const Color _warningDark = Color(0xffFBBF24);

  static const Color hintLight =
      Color(0xff6B7280); // Updated to match gray text from image
  static const Color hintDark = Color(0xffA1A1AA);

  /// Success color for positive status (extracted from green card in image)
  static const Color successLight = Color(0xff10B981);
  static const Color successDark = Color(0xff4ADE80);

  static Color getWarningColor(BuildContext context) =>
      context.isLight ? _warningLight : _warningDark;

  static Color getErrorColor(BuildContext context) =>
      context.isLight ? errorLight : errorDark;

  static Color getSuccessColor(BuildContext context) =>
      context.isLight ? successLight : successDark;

  static Color getNormalTextColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSurface;

  static Color getHintColor(BuildContext context) =>
      context.isLight ? hintLight : hintDark;

  /// Cards - Updated to match the white/light cards from the image
  static const Color cardLight = Color(0xffFFFFFF);
  static const Color cardDark = Color(0xff1E293B);

  static const Color _cardErrorLight =
      Color(0xffFEF2F2); // Light red background
  static const Color _cardErrorDark = Color(0xff3F1F1F);

  static const Color _cardWarningLight =
      Color(0xffFFFBEB); // Light orange/yellow background
  static const Color _cardWarningDark = Color(0xff3F3B1F);

  static const Color _cardSuccessLight =
      Color(0xffF0FDF4); // Light green background
  static const Color _cardSuccessDark = Color(0xff1F3F25);

  static Color getCardNormalColor(BuildContext context) =>
      context.isLight ? cardLight : cardDark;

  static Color getCardErrorColor(BuildContext context) =>
      context.isLight ? _cardErrorLight : _cardErrorDark;

  static Color getCardWarningColor(BuildContext context) =>
      context.isLight ? _cardWarningLight : _cardWarningDark;

  static Color getCardSuccessColor(BuildContext context) =>
      context.isLight ? _cardSuccessLight : _cardSuccessDark;

  static Color getCardConsumableItemColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.isNormalText(index)
          ? getCardNormalColor(context)
          : _getCardConsumableItemAbnormalColor(context,
              cubit: cubit, index: index);

  static Color _getCardConsumableItemAbnormalColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.isErrorText(index) || cubit.isConsiderText(index)
          ? _getCardConsumableItemErrorColor(context,
              cubit: cubit, index: index)
          : _getCardWarningColor(context, cubit: cubit, index: index);

  static Color _getCardConsumableItemErrorColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.isErrorText(index) || cubit.isConsiderText(index)
          ? context.isLight
              ? _cardErrorLight
              : _cardErrorDark
          : getCardNormalColor(context);

  static Color _getCardWarningColor(BuildContext context,
          {required ConsumableCubit cubit, required int index}) =>
      cubit.isWarningText(index)
          ? context.isLight
              ? _cardWarningLight
              : _cardWarningDark
          : getCardNormalColor(context);
}
