import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_ids.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/ads/banner_ad_widget.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: AppDimens.padding15),
          child: Row(
            children: [
              Expanded(
                child: AnimatedButtonWithIcon(
                  icon: MdiIcons.plus,
                  text: AppStrings.btnAddCar(context),
                  onPressed: () => Navigator.pushNamed(context, Routes.carInfoRoute),
                ),
              ),
              const SizedBox(width: AppDimens.sizedBox10),
              Expanded(
                child: AnimatedButton(
                  text: AppStrings.btnReturn(context).toUpperCase(),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.sizedBox15.r),
        const BannerAdWidget(androidAdUnitId: AppIDs.adUnitMyCars),
      ],
    );
  }
}
