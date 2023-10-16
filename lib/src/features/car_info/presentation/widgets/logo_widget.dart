import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/texts/title_text.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetManager.icon, height: AppDimens.imageHeight100),
        const SizedBox(width: AppDimens.sizedBox10),
        TitleText(text: AppStrings.appName(context).toUpperCase()),
      ],
    );
  }
}
