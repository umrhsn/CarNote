import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/services/text_input_formatters/title_case_input_formatter.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/asset_manager.dart';
import 'package:car_note/src/core/widgets/animated_title.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/core/widgets/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CarInfo> {
  @override
  Widget build(BuildContext context) {
    final CarCubit cubit = CarCubit.get(context);
    final validator = Provider.of<FormValidation>(context);

    CustomTextFormField buildCarTypeTextFormField() {
      return CustomTextFormField(
        controller: cubit.carTypeController,
        focusNode: cubit.carTypeFocus,
        hintText: AppStrings.carTypeHint,
        inputFormatters: [TitleCaseInputFormatter()],
        validationItem: validator.carType,
        validateItemForm: (value) => validator.validateCarTypeForm(value),
        onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, cubit.modelYearFocus),
      );
    }

    CustomTextFormField buildModelYearTextFormField() {
      return CustomTextFormField(
        controller: cubit.modelYearController,
        focusNode: cubit.modelYearFocus,
        keyboardType: TextInputType.number,
        hintText: AppStrings.modelYearHint,
        inputFormatters: [LengthLimitingTextInputFormatter(4)],
        validationItem: validator.modelYear,
        validateItemForm: (value) => validator.validateModelYearForm(value),
        onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, cubit.currentKmFocus),
      );
    }

    CustomTextFormField buildCurrentKmTextFormField() {
      return CustomTextFormField(
        controller: cubit.currentKmController,
        focusNode: cubit.currentKmFocus,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.number,
        inputFormatters: [
          ThousandSeparatorInputFormatter(),
          LengthLimitingTextInputFormatter(9),
          FilteringTextInputFormatter.digitsOnly,
        ],
        hintText: AppStrings.currentKmHint,
        validationItem: validator.currentKm,
        validateItemForm: (value) => validator.validateCurrentKmForm(value),
        onFieldSubmitted: (_) => cubit.writeDataAndNavigate(context),
      );
    }

    CustomButton buildContinueButton() {
      return CustomButton(
          text: AppStrings.btnContinue.toUpperCase(),
          btnEnabled: validator.isValid,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool(AppStrings.prefsBoolSeen, true);
            cubit.writeDataAndNavigate(context);
          });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
                      AnimatedTitle(text: AppStrings.appName.toUpperCase()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  buildCarTypeTextFormField(),
                  buildModelYearTextFormField(),
                  buildCurrentKmTextFormField(),
                  const SizedBox(height: 15),
                  buildContinueButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
