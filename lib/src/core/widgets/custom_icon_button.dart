import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  bool btnEnabled;
  final void Function()? onPressed;
  String? tooltip;

  CustomIconButton({
    Key? key,
    required this.icon,
    required this.btnEnabled,
    required this.onPressed,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: btnEnabled ? onPressed : null,
      style: !btnEnabled
          ? ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)))
          : ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  context.isLight ? AppColors.iconLight : AppColors.iconDark)),
      icon: Icon(icon),
      tooltip: tooltip,
    );
  }
}
