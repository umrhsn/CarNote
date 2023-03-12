import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  final String text;

  const AnimatedTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: AnimatedTextKit(
        // AnimatedTextKit doesn't change its state without having this key
        key: ValueKey<bool>(context.isLight),
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            textStyle: TextStyle(
              color: context.isLight ? Colors.black.withAlpha(950) : Colors.white.withAlpha(950),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
            speed: const Duration(milliseconds: 200),
          ),
        ],
        totalRepeatCount: 1,
      ),
    );
  }
}
