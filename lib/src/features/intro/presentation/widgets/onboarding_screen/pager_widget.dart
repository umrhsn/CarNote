import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/features/intro/domain/entities/onboarding_page.dart';
import 'package:car_note/src/features/intro/presentation/widgets/onboarding_screen/hint_text.dart';
import 'package:car_note/src/features/intro/presentation/widgets/onboarding_screen/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagerWidget extends StatelessWidget {
  final OnboardingPage data;

  const PagerWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: AppDimens.sizedBox30.r),
            AspectRatio(aspectRatio: 0.9.r, child: Image.asset(data.image)),
            SizedBox(height: AppDimens.sizedBox20.r),
            TitleText(text: data.title),
            SizedBox(height: AppDimens.sizedBox10.r),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding70),
              child: HintText(text: data.subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
