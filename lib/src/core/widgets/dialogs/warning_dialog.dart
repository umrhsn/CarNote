import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: must_be_immutable
class WarningDialog extends StatelessWidget {
  WarningDialog({
    super.key,
    required this.title,
    required this.content,
    required this.positiveAction,
    required this.positiveText,
    required this.negativeAction,
    required this.negativeText,
    this.neutralAction,
    this.neutralText,
  });

  String title;
  String content;
  void Function()? positiveAction;
  String positiveText;
  void Function()? negativeAction;
  String negativeText;
  void Function()? neutralAction;
  String? neutralText;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.synchronized(
      child: SlideAnimation(
        child: FadeInAnimation(
          child: AlertDialog(
            icon: Icon(Icons.warning_rounded, size: AppDimens.iconSize50),
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: positiveAction,
                child: Text(positiveText.toUpperCase()),
              ),
              TextButton(
                onPressed: negativeAction,
                child: Text(negativeText.toUpperCase()),
              ),
              neutralText != null && neutralAction != null
                  ? TextButton(onPressed: neutralAction, child: Text(neutralText!.toUpperCase()))
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
