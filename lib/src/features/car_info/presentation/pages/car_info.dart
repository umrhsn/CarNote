import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/services/form_validation/validation_item.dart';
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_text_input_formatter.dart';
import 'package:car_note/src/core/services/text_input_formatters/uppercase_text_input_formatter.dart';
import 'package:car_note/src/core/widgets/custom_button.dart';
import 'package:car_note/src/core/widgets/custom_text_form_field.dart';
import 'package:car_note/src/features/car_info/presentation/pages/maintenance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarInfo extends StatefulWidget {
  const CarInfo({super.key});

  @override
  State<CarInfo> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CarInfo> {
  final TextEditingController _carTypeController = TextEditingController();
  final TextEditingController _modelYearController = TextEditingController();
  final TextEditingController _distanceTravelledController = TextEditingController();

  final FocusNode _carTypeFocus = FocusNode();
  final FocusNode _modelYearFocus = FocusNode();
  final FocusNode _distanceTravelledFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final formValidationProvider = Provider.of<FormValidation>(context);
    final bool btnEnabled = formValidationProvider.isValid;

    final getCarTypeValidationItem = formValidationProvider.carType;
    final getModelYearValidationItem = formValidationProvider.modelYear;
    final getDistanceTravelledValidationItem = formValidationProvider.distanceTravelled;

    void validateCarTypeForm(String? value) => formValidationProvider.validateCarTypeForm(value);
    void validateModelYearForm(String? value) =>
        formValidationProvider.validateModelYearForm(value);
    void validateDistanceTravelledForm(String? value) =>
        formValidationProvider.validateDistanceTravelledForm(value);

    void navigateToMaintenanceScreen() {
      // TODO: add data to database before navigating
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MaintenanceScreen();
      }));
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
                  buildCarTypeTextFormField(getCarTypeValidationItem, validateCarTypeForm, context),
                  buildModelYearTextFormField(
                      getModelYearValidationItem, validateModelYearForm, context),
                  buildDistanceTravelledTextFormField(
                    getDistanceTravelledValidationItem,
                    validateDistanceTravelledForm,
                    navigateToMaintenanceScreen,
                  ),
                  const SizedBox(height: 8),
                  buildContinueButton(btnEnabled, navigateToMaintenanceScreen)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomTextFormField buildCarTypeTextFormField(ValidationItem getCarTypeValidationItem,
      void Function(String? value) validateCarTypeForm, BuildContext context) {
    return CustomTextFormField(
      controller: _carTypeController,
      focusNode: _carTypeFocus,
      hintText: 'Car type. e.g. "Suzuki Maruti"',
      inputFormatters: [UpperCaseTextInputFormatter()],
      validationItem: getCarTypeValidationItem,
      validateItemForm: validateCarTypeForm,
      onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, _modelYearFocus),
    );
  }

  CustomTextFormField buildModelYearTextFormField(ValidationItem getModelYearValidationItem,
      void Function(String? value) validateModelYearForm, BuildContext context) {
    return CustomTextFormField(
      controller: _modelYearController,
      focusNode: _modelYearFocus,
      keyboardType: TextInputType.number,
      hintText: 'Model year. e.g. "2014"',
      inputFormatters: [LengthLimitingTextInputFormatter(4)],
      validationItem: getModelYearValidationItem,
      validateItemForm: validateModelYearForm,
      onFieldSubmitted: (_) => CustomTextFormField.requestFocus(context, _distanceTravelledFocus),
    );
  }

  CustomTextFormField buildDistanceTravelledTextFormField(
    ValidationItem getDistanceTravelledValidationItem,
    void Function(String? value) validateDistanceTravelledForm,
    void Function() navigateToMaintenanceScreen,
  ) {
    return CustomTextFormField(
      controller: _distanceTravelledController,
      focusNode: _distanceTravelledFocus,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      inputFormatters: [
        ThousandSeparatorTextInputFormatter(),
        LengthLimitingTextInputFormatter(9),
      ],
      hintText: 'Total distance travelled. e.g. ${NumberFormat.decimalPattern().format(100000)} km',
      validationItem: getDistanceTravelledValidationItem,
      validateItemForm: validateDistanceTravelledForm,
      onFieldSubmitted: (_) => navigateToMaintenanceScreen(),
    );
  }

  CustomButton buildContinueButton(bool btnEnabled, void Function() navigateToMaintenanceScreen) {
    return CustomButton(btnEnabled: btnEnabled, onPressed: () => navigateToMaintenanceScreen());
  }
}
