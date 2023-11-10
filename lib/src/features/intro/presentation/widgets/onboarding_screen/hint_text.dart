import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
          style: TextStyle(color: AppColors.getHintColor(context)),
        ),
      ),
    );
  }
}
