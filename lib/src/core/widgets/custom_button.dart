import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.btnEnabled,
    required this.onPressed,
  }) : super(key: key);

  final bool btnEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: btnEnabled ? onPressed : null,
      style: !btnEnabled
          ? ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              foregroundColor: MaterialStateProperty.all(context.isLight
                  ? AppColors.scaffoldBackgroundLight
                  : AppColors.scaffoldBackgroundLight.withAlpha(60)),
              backgroundColor: MaterialStateProperty.all(
                  context.isLight ? AppColors.btnDisabledLight : AppColors.btnDisabledDark),
            )
          : const ButtonStyle(),
      child: Text(AppStrings.btnContinue.toUpperCase()),
    );
  }
}
