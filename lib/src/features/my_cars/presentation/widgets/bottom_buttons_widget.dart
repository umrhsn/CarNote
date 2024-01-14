import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomButtonsWidget extends StatelessWidget {
  const BottomButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: AnimatedButtonWithIcon(
              icon: MdiIcons.plus,
              text: AppStrings.btnAddCar(context),
              onPressed: () {},
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
    );
  }
}
