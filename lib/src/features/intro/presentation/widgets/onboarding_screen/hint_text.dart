import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HintText extends StatelessWidget {
  const HintText({
    super.key,
    required this.text,
    this.alignment = Alignment.center,
    this.onTap,
    this.textAlign = TextAlign.center,
  });

  final Alignment? alignment;
  final TextAlign? textAlign;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment!,
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          textAlign: textAlign,
          style: TextStyle(fontSize: AppDimens.fontSize15, color: AppColors.getHintColor(context)),
        ),
      ),
    );
  }
}
