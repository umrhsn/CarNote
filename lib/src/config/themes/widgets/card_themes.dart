import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppCardThemes {
  static CardThemeData cardTheme({required bool isLight}) => CardThemeData(
        color: isLight ? AppColors.cardLight : AppColors.cardDark,
        shadowColor: isLight ? AppColors.boxShadowLight : AppColors.boxShadowDark,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  static CardThemeData elevatedCardTheme({required bool isLight}) => CardThemeData(
        color: isLight ? AppColors.cardLight : AppColors.cardDark,
        shadowColor: isLight ? AppColors.boxShadowLight : AppColors.boxShadowDark,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

  static CardThemeData statusCardTheme({required bool isLight, required CardStatus status}) {
    Color cardColor;
    switch (status) {
      case CardStatus.error:
        cardColor = isLight ? AppColors.cardErrorLight : AppColors.cardErrorDark;
        break;
      case CardStatus.warning:
        cardColor = isLight ? AppColors.cardWarningLight : AppColors.cardWarningDark;
        break;
      case CardStatus.success:
        cardColor = isLight ? AppColors.cardSuccessLight : AppColors.cardSuccessDark;
        break;
      case CardStatus.normal:
      default:
        cardColor = isLight ? AppColors.cardLight : AppColors.cardDark;
        break;
    }

    return CardThemeData(
      color: cardColor,
      shadowColor: isLight ? AppColors.boxShadowLight : AppColors.boxShadowDark,
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isLight ? Colors.grey.withOpacity(0.1) : Colors.grey.withOpacity(0.2),
          width: 1.0,
        ),
      ),
    );
  }
}

enum CardStatus {
  normal,
  error,
  warning,
  success,
}
