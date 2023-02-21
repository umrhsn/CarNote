import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/services/text_input_formatters/uppercase_text_input_formatter.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
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

    final formValidationProvider = Provider.of<FormValidation>(context);
    final bool btnEnabled = formValidationProvider.isValid;

    final getCarTypeValidationItem = formValidationProvider.carType;
    final getModelYearValidationItem = formValidationProvider.modelYear;
    final getCurrentKmValidationItem = formValidationProvider.currentKm;

    void validateCarTypeForm(String? value) => formValidationProvider.validateCarTypeForm(value);
    void validateModelYearForm(String? value) =>
        formValidationProvider.validateModelYearForm(value);
    void validateCurrentKmForm(String? value) =>
        formValidationProvider.validateCurrentKmForm(value);

    CustomTextFormField buildCarTypeTextFormField() {
      return CustomTextFormField(
        controller: cubit.carTypeController,
        focusNode: cubit.carTypeFocus,
        hintText: AppStrings.carTypeHint,
        inputFormatters: [UpperCaseTextInputFormatter()],
        validationItem: getCarTypeValidationItem,
        validateItemForm: validateCarTypeForm,
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
        validationItem: getModelYearValidationItem,
        validateItemForm: validateModelYearForm,
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
          ThousandSeparatorTextInputFormatter(),
          LengthLimitingTextInputFormatter(9),
        ],
        hintText: AppStrings.currentKmHint,
        validationItem: getCurrentKmValidationItem,
        validateItemForm: validateCurrentKmForm,
        onFieldSubmitted: (_) => cubit.writeDataAndNavigate(context),
      );
    }

    CustomButton buildContinueButton() {
      return CustomButton(
          text: AppStrings.btnContinue.toUpperCase(),
          btnEnabled: btnEnabled,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('seen', true);
            cubit.writeDataAndNavigate(context);
          });
    }

    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCarTypeTextFormField(),
                  buildModelYearTextFormField(),
                  buildCurrentKmTextFormField(),
                  const SizedBox(height: 8),
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
