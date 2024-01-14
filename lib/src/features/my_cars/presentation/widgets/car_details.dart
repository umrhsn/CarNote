import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/features/my_cars/presentation/widgets/car_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(child: Icon(MdiIcons.carSide)),
          SizedBox(width: AppDimens.sizedBox10.r),
          const CarData(),
        ],
      ),
    );
  }
}
