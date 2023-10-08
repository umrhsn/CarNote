import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/services/form_validation/form_validation.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/widgets/buttons/animated_button.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

class ContinueButton extends StatelessWidget {
  ContinueButton({
    super.key,
    required this.validator,
    required this.carCubit,
  });

  final SharedPreferences _prefs = di.sl<SharedPreferences>();
  final FormValidation validator;
  final CarCubit carCubit;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
        text: AppStrings.btnContinue(context),
        btnEnabled: validator.isValid,
        onPressed: () async {
          _prefs.setBool(AppKeys.prefsBoolSeen, true);
          DatabaseHelper.writeCarData(context).then((value) => carCubit.navigateToConsumablesScreen(context));
        });
  }
}
