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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppDimens.sizedBox30.r),
            Center(
              child: AspectRatio(aspectRatio: 1, child: Image.asset(data.image)),
            ),
            TitleText(text: data.title),
            SizedBox(height: AppDimens.sizedBox8.r),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimens.padding30.r),
              child: HintText(text: data.subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
