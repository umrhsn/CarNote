import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContinueButtonWidget extends StatelessWidget {
  const ContinueButtonWidget({
    super.key,
    required this.arSelected,
    required this.enSelected,
  });

  final bool arSelected;
  final bool enSelected;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(height: AppDimens.sizedBox30.r),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.padding10.r),
            child: SizedBox(
              width: double.infinity,
              child: !arSelected && !enSelected
                  ? AnimatedButtonWithIcon(icon: Icons.arrow_forward, btnEnabled: false, onPressed: null)
                  : AnimatedButton(
                      text: AppStrings.btnContinue(context), onPressed: () => Navigator.pushReplacementNamed(context, Routes.onboardingRoute)),
            ),
          ),
        ],
      ),
    );
  }
}
