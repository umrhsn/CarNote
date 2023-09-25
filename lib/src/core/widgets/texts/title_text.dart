import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  String text;

  TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.isLight ? Colors.black.withAlpha(950) : Colors.white.withAlpha(950),
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
