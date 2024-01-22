import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/widgets/logo/logo_widget.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/my_cars_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoAndMyCarsListWidgets extends StatelessWidget {
  const LogoAndMyCarsListWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const LogoWidget(),
          SizedBox(height: AppDimens.sizedBox15.r),
          const MyCarsList(),
        ],
      ),
    );
  }
}
