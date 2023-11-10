import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  String text;

  TitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.isLight ? Colors.black.withAlpha(950) : Colors.white.withAlpha(950),
        fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize?.r,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
