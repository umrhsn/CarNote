import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
  });

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: AppDimens.fontSize20, fontWeight: FontWeight.bold), textAlign: textAlign);
  }
}
