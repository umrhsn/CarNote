import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/buttons/animated_icon_button.dart';
import 'package:car_note/src/core/widgets/texts/title_text.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/car_type_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/continue_button.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/current_kilometer_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/model_year_text_form_field.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CarInfoScreen> {
  @override
  void initState() {
    super.initState();
    if (AppTourService.shouldBeginTour(prefsBoolKey: AppKeys.prefsBoolBeginCarInfoScreenTour)) {
      AppTourService.beginCarInfoScreenTour(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = LocaleCubit.get(context);
    final CarCubit carCubit = CarCubit.get(context);
    final validator = Provider.of<FormValidation>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Align(
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
          ),
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.padding20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetManager.icon, height: AppDimens.imageHeight100),
                          const SizedBox(width: AppDimens.sizedBox10),
                          TitleText(text: AppStrings.appName(context).toUpperCase()),
                        ],
                      ),
                      const SizedBox(height: AppDimens.sizedBox20),
                      CarTypeTextFormField(carCubit: carCubit, validator: validator),
                      ModelYearTextFormField(carCubit: carCubit, validator: validator),
                      CurrentKilometerTextFormField(carCubit: carCubit, validator: validator),
                      const SizedBox(height: AppDimens.sizedBox15),
                      ContinueButton(validator: validator, carCubit: carCubit),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const BannerAdWidget(),
        ],
      ),
    );
  }
}
