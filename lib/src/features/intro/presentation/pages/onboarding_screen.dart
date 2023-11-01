import 'dart:async';

import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_lists.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/features/intro/presentation/widgets/onboarding_screen/pager_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _sliderTimer;
  int _currentShowIndex = 0;

  @override
  void initState() {
    super.initState();
    _sliderTimer = Timer.periodic(const Duration(seconds: AppNums.durationOnboarding), (timer) {
      if (_currentShowIndex == 0) {
        _pageController.animateTo(context.width, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentShowIndex == 1) {
        _pageController.animateTo(context.width * 2, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentShowIndex == 2) {
        _pageController.animateTo(context.width * 3, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (_currentShowIndex == 3) {
        _pageController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildBodyContent(),
    );
  }

  Column _buildBodyContent() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: context.paddingTop),
          _buildPager(),
          _buildPageIndicator(),
          _buildPageButtons(context),
          // const BannerAdWidget()
        ],
      );

  Padding _buildPageButtons(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppDimens.padding20),
        child: Column(
          children: [
            AnimatedButton(
              text: AppStrings.btnContinue(context),
              onPressed: () => Navigator.pushReplacementNamed(context, Routes.carInfoRoute),
            ),
          ],
        ),
      );

  SmoothPageIndicator _buildPageIndicator() => SmoothPageIndicator(
        controller: _pageController, // PageController
        count: AppLists.onboardingPages(context).length,
        effect: WormEffect(
          activeDotColor: AppColors.getPrimaryColor(context),
          dotColor: AppColors.getHintColor(context).withAlpha(100),
          dotHeight: 6.r,
          dotWidth: 16.r,
          spacing: 15.r,
        ),
      );

  Expanded _buildPager() => Expanded(
        child: PageView(
          controller: _pageController,
          pageSnapping: true,
          onPageChanged: (index) => _currentShowIndex = index,
          scrollDirection: Axis.horizontal,
          children: List.generate(AppLists.onboardingPagesCount, (index) => PagerWidget(data: AppLists.onboardingPages(context)[index])),
        ),
      );
}
