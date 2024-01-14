import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:flutter/material.dart';

class CarData extends StatelessWidget {
  const CarData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(
        'Nissan Sunny 2011',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: context.isTablet ? AppDimens.labelSmall : AppDimens.labelLarge,
        ),
      ),
    );
  }
}
