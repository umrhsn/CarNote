import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_icon_button.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwitchLangButtonWidget extends StatelessWidget {
  const SwitchLangButtonWidget({
    super.key,
    required this.localeCubit,
  });

  final LocaleCubit localeCubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: AppDimens.padding20, right: AppDimens.padding15),
        child: AnimatedIconButton(
          key: AppKeys.keySwitchLangConsumablesScreen,
          faIcon: true,
          icon: FontAwesomeIcons.language,
          onPressed: () => AppLocalizations.of(context)!.isEnLocale
              ? localeCubit.toArabic(context, showToast: true)
              : localeCubit.toEnglish(context, showToast: true),
          tooltip: AppStrings.switchLangTooltip(context),
        ),
      ),
    );
  }
}
