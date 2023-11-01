import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:car_note/src/features/intro/presentation/widgets/language_selection_screen_widgets/choose_language_text_widget.dart';
import 'package:car_note/src/features/intro/presentation/widgets/language_selection_screen_widgets/continue_button_widget.dart';
import 'package:car_note/src/features/intro/presentation/widgets/language_selection_screen_widgets/language_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> with TickerProviderStateMixin {
  late AnimationController _arAnimationController;
  late AnimationController _enAnimationController;
  bool _arSelected = false;
  bool _enSelected = false;

  @override
  void initState() {
    super.initState();
    _arAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: AppNums.durationForwardButtonAnimation));
    _enAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: AppNums.durationForwardButtonAnimation));
  }

  @override
  void dispose() {
    _arAnimationController.dispose();
    _enAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: context.isTablet ? 190.w : 190.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ChooseLanguageTextWidget(),
                    SizedBox(height: AppDimens.sizedBox15.r),
                    _buildLangWidgetsRow(context),
                    ContinueButtonWidget(arSelected: _arSelected, enSelected: _enSelected),
                  ],
                ),
              ),
            ),
          ),
          // const BannerAdWidget(),
        ],
      ),
    );
  }

  Row _buildLangWidgetsRow(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildArLangWidget(context),
          SizedBox(width: AppDimens.sizedBox10.r),
          _buildEnLangWidget(context),
        ],
      );

  InkWell _buildArLangWidget(BuildContext context) => InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          _triggerAnimation(controller: _arAnimationController);
          setState(() {
            _arSelected = true;
            _enSelected = false;
          });
          LocaleCubit.get(context).toArabic(context, showToast: false);
        },
        child: LanguageSelectionWidget(
          isSelected: _arSelected,
          image: AssetManager.ar,
          animationController: _arAnimationController,
        ),
      );

  InkWell _buildEnLangWidget(BuildContext context) => InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () {
          _triggerAnimation(controller: _enAnimationController);
          setState(() {
            _arSelected = false;
            _enSelected = true;
          });
          LocaleCubit.get(context).toEnglish(context, showToast: false);
        },
        child: LanguageSelectionWidget(
          isSelected: _enSelected,
          image: AssetManager.en,
          animationController: _enAnimationController,
        ),
      );

  void _triggerAnimation({required AnimationController controller}) {
    controller.forward();
    Future.delayed(const Duration(milliseconds: AppNums.durationReverseButtonAnimation), () => controller.reverse());
  }
}
