import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  bool btnEnabled;
  final void Function()? onPressed;

  CustomButton({
    Key? key,
    required this.text,
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
      child: Text(text),
    );
  }
}
