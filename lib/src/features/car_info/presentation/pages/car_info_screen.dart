import 'package:car_note/src/core/services/app_tutorial/app_tour_service.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/car_type_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/continue_button.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/current_kilometer_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/logo_widget.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/model_year_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/widgets/switch_lang_button_widget.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(AppDimens.padding20.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoWidget(),
                      SizedBox(height: AppDimens.sizedBox20.r),
                      CarTypeTextFormField(carCubit: carCubit, validator: validator),
                      ModelYearTextFormField(carCubit: carCubit, validator: validator),
                      CurrentKilometerTextFormField(carCubit: carCubit, validator: validator),
                      SizedBox(height: AppDimens.sizedBox15.r),
                      ContinueButton(validator: validator, carCubit: carCubit),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SwitchLangButtonWidget(localeCubit: localeCubit),
          // const BannerAdWidget(),
        ],
      ),
    );
  }
}
