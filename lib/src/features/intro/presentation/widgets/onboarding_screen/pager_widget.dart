import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/features/intro/presentation/widgets/onboarding_screen/hint_text.dart';
import 'package:car_note/src/features/intro/presentation/widgets/onboarding_screen/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PagePopup extends StatelessWidget {
  final PageData data;

  const PagePopup({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: AppDimens.sizedBox30.r),
            Center(
              child: SizedBox(
                width: context.width - 100,
                child: AspectRatio(aspectRatio: 0.7, child: Image.asset(data.image)),
              ),
            ),
            SizedBox(height: AppDimens.sizedBox20.r),
            TitleText(text: data.title),
            SizedBox(height: AppDimens.sizedBox10.r),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: HintText(text: data.subtitle),
            ),
          ],
        ),
      ),
    );
  }
}

class PageData {
  final String title;
  final String subtitle;
  final String image;

  PageData({required this.title, required this.subtitle, required this.image});
}
