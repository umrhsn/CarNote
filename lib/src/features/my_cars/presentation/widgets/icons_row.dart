import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconsRow extends StatelessWidget {
  const IconsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 90.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: AnimatedIconButton(icon: MdiIcons.pencil, onPressed: () {}, tooltip: AppStrings.editCarDataTooltip(context))),
            Flexible(child: AnimatedIconButton(icon: MdiIcons.deleteForever, onPressed: () {}, tooltip: AppStrings.removeCarTooltip(context))),
            Flexible(child: AnimatedIconButton(icon: MdiIcons.share, onPressed: () {}, tooltip: AppStrings.shareCarDataTooltip(context))),
          ],
        ),
      ),
    );
  }
}
