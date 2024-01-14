import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/car_details.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/icons_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCarsListItem extends StatelessWidget {
  const MyCarsListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: AppDimens.padding15.r, vertical: AppDimens.padding8.r),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [CarDetails(), IconsRow()],
        ),
      ),
    );
  }
}
