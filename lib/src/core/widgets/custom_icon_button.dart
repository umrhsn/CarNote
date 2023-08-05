import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  bool btnEnabled;
  final void Function()? onPressed;

  CustomIconButton({
    Key? key,
    required this.iconData,
    required this.btnEnabled,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btnEnabled ? onPressed : null,
      style: !btnEnabled
          ? ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              foregroundColor:
                  MaterialStateProperty.all(AppColors.getBtnDisabledForeground(context)),
              backgroundColor:
                  MaterialStateProperty.all(AppColors.getBtnDisabledBackground(context)),
            )
          : const ButtonStyle(),
      child: Icon(iconData),
    );
  }
}
