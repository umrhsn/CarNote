import 'package:flutter/material.dart';

class ChooseLanguageTextWidget extends StatelessWidget {
  const ChooseLanguageTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        "اخــــتَـــــــر اللُّــــغَــــــــة\nCHOOSE LANGUAGE",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge!.fontSize, fontWeight: FontWeight.bold),
      ),
    );
  }
}
