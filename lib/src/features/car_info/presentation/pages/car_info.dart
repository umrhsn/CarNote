import 'package:admob_flutter/admob_flutter.dart';
import 'package:car_note/src/config/locale/app_localizations.dart';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/title_text.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/core/widgets/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CarInfo> {
  @override
  void initState() {
    super.initState();
    Admob.requestTrackingAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    final LocaleCubit localeCubit = LocaleCubit.get(context);
    final CarCubit carCubit = CarCubit.get(context);
    final validator = Provider.of<FormValidation>(context);

    CustomTextFormField buildCarTypeTextFormField() {
      return CustomTextFormField(
        controller: carCubit.carTypeController,
        focusNode: carCubit.carTypeFocus,
        hintText: AppStrings.carTypeHint(context),
        validationItem: validator.carType,
        validateItemForm: (value) => validator.validateCarTypeForm(value, context),
        onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, carCubit.modelYearFocus),
      );
    }

    CustomTextFormField buildModelYearTextFormField() {
      return CustomTextFormField(
        controller: carCubit.modelYearController,
        focusNode: carCubit.modelYearFocus,
        keyboardType: TextInputType.number,
        hintText: AppStrings.modelYearHint(context),
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: TextStyle(fontFamily: AppStrings.fontFamily),
        validationItem: validator.modelYear,
        validateItemForm: (value) => validator.validateModelYearForm(value, context),
        onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, carCubit.currentKmFocus),
      );
    }

    CustomTextFormField buildCurrentKmTextFormField() {
      return CustomTextFormField(
        controller: carCubit.currentKmController,
        focusNode: carCubit.currentKmFocus,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly,
          ThousandSeparatorInputFormatter(),
        ],
        style: TextStyle(fontFamily: AppStrings.fontFamily),
        hintText:
            "${AppStrings.currentKmHint(context)} ${100000.toThousands()} ${AppStrings.km(context)}",
        validationItem: validator.currentKm,
        validateItemForm: (value) => validator.validateCurrentKmForm(value, context),
        onFieldSubmitted: (_) => DatabaseHelper.writeCarData(context)
            .then((value) => carCubit.navigateToConsumablesScreen(context)),
      );
    }

    CustomButton buildContinueButton() {
      return CustomButton(
          text: AppStrings.btnContinue(context),
          btnEnabled: validator.isValid,
          onPressed: () async {
            SharedPreferences prefs = di.sl<SharedPreferences>();
            prefs.setBool(AppStrings.prefsBoolSeen, true);
            DatabaseHelper.writeCarData(context)
                .then((value) => carCubit.navigateToConsumablesScreen(context));
          });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 15),
              child: IconButton(
                icon: const FaIcon(FontAwesomeIcons.language),
                onPressed: () => AppLocalizations.of(context)!.isEnLocale
                    ? localeCubit.toArabic(context)
                    : localeCubit.toEnglish(context),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetManager.icon, height: 100),
                          const SizedBox(width: 10),
                          TitleText(text: AppStrings.appName(context).toUpperCase()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      buildCarTypeTextFormField(),
                      buildModelYearTextFormField(),
                      buildCurrentKmTextFormField(),
                      const SizedBox(height: 15),
                      buildContinueButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: AdmobBanner(
          //     adUnitId: AdServices.getBannerAdUnitId(),
          //     adSize: AdmobBannerSize.ADAPTIVE_BANNER(width: context.width.toInt()),
          //   ),
          // )
        ],
      ),
    );
  }
}
