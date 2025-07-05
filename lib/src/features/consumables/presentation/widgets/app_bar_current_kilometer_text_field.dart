// lib/src/features/consumables/presentation/widgets/app_bar_current_kilometer_text_field.dart
import 'package:car_note/src/core/services/text_input_formatters/thousand_separator_input_formatter.dart';
import 'package:car_note/src/core/utils/app_colors.dart';
import 'package:car_note/src/core/utils/app_dimens.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_nums.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarCurrentKilometerTextField extends StatelessWidget {
  const AppBarCurrentKilometerTextField({
    super.key,
    required this.consumableCubit,
  });

  final ConsumableCubit consumableCubit;

  String _getCarDisplayText(BuildContext context) {
    // Get car data from CarCubit
    final carCubit = BlocProvider.of<CarCubit>(context);

    return BlocBuilder<CarCubit, CarState>(
      builder: (context, state) {
        if (state is CarLoaded && state.car != null) {
          final car = state.car!;
          return Text('${car.type} ${car.modelYear}');
        } else if (state is CarError) {
          return Text('Error loading car');
        } else if (state is CarLoading) {
          return Text('Loading...');
        } else {
          // Try to get car data if not loaded
          carCubit.getCar();
          return Text('No car data');
        }
      },
    ).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        TextFormField(
          key: AppKeys.keyAppBarTextField,
          focusNode: consumableCubit.currentKmFocus,
          cursorColor: AppColors.getTextFieldBorderAndLabel(context),
          controller: consumableCubit.currentKmController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: AppStrings.fontFamily, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            floatingLabelStyle: TextStyle(
              color: consumableCubit.currentKmFocus.hasFocus
                  ? AppColors.getTextFieldBorderAndLabelFocused(context)
                  : AppColors.getTextFieldBorderAndLabel(context),
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.getTextFieldBorderAndLabel(context),
              ),
            ),
            labelText: AppStrings.currentKmLabel(context),
            labelStyle:
                TextStyle(color: AppColors.getAppBarTextFieldLabel(context)),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(AppNums.lengthLimit9),
            FilteringTextInputFormatter.digitsOnly,
            ThousandSeparatorInputFormatter(),
          ],
          onChanged: (_) {
            consumableCubit.validateAllLastChangedKilometerFields(context);
            consumableCubit.validateAllChangeKilometerFields(context);
          },
          onEditingComplete: () =>
              consumableCubit.validateAllChangeKilometerFields(context),
          autovalidateMode: AutovalidateMode.always,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
              end: AppDimens.padding8, bottom: AppDimens.padding8),
          child: BlocBuilder<CarCubit, CarState>(
            builder: (context, state) {
              String carDisplayText;

              if (state is CarLoaded && state.car != null) {
                final car = state.car!;
                carDisplayText = '${car.type} ${car.modelYear}';
              } else if (state is CarError) {
                carDisplayText = 'Error loading car';
              } else if (state is CarLoading) {
                carDisplayText = 'Loading...';
              } else {
                // Try to get car data if not loaded
                BlocProvider.of<CarCubit>(context).getCar();
                carDisplayText = 'No car data';
              }

              return Text(
                carDisplayText,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: AppColors.getHintColor(context),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
