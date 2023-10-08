import 'package:car_note/src/core/extensions/media_query_values.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key,required this.list});

  final List? list;

  @override
  Widget build(BuildContext context) {
    return list!.isEmpty ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AssetManager.nothingHere, height: context.height / 5),
        const SizedBox(height: AppDimens.sizedBox15),
        Text(
          AppStrings.nothingHere(context),
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.sizedBox10),
        Text(
          AppStrings.tryToAddItems(context),
          style: TextStyle(color: AppColors.getHintColor(context)),
          textAlign: TextAlign.center,
        ),
      ],
    ) : const SizedBox();
  }
}
