import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({
    super.key,
    required this.isSelected,
    required this.image,
    required this.animationController,
  });

  final bool isSelected;
  final String image;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimens.padding8.r),
      child: ScaleTransition(
        scale: Tween<double>(begin: AppNums.tweenBegin, end: AppNums.tweenEnd).animate(animationController),
        child: Container(
            foregroundDecoration: context.isLight
                ? BoxDecoration(color: isSelected ? Colors.transparent : AppColors.boxShadowLight, backgroundBlendMode: BlendMode.color)
                : BoxDecoration(
                    color: isSelected ? Colors.transparent : AppColors.boxShadowDark,
                    backgroundBlendMode: isSelected ? BlendMode.color : BlendMode.saturation,
                  ),
            child: Image.asset(image, height: context.isTablet ? 70.w : 70.h)),
      ),
    );
  }
}
