import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/bottom_buttons_widget.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/logo_and_my_cars_list_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCarsScreenWidget extends StatelessWidget {
  const MyCarsScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            const LogoAndMyCarsListWidgets(),
            SizedBox(height: AppDimens.sizedBox15.r),
            const BottomButtonsWidget(),
          ],
        ),
      ),
    );
  }

}

