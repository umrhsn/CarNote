import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  String text;

  TitleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Text(
        text,
        style: TextStyle(
          color: context.isLight ? Colors.black.withAlpha(950) : Colors.white.withAlpha(950),
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
