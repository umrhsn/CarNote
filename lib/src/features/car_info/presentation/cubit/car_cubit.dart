// lib/src/features/car_info/presentation/cubit/car_cubit.dart
import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/get_car_use_case.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/save_car_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  final SaveCarUseCase saveCarUseCase;
  final GetCarUseCase getCarUseCase;

  CarCubit({
    required this.saveCarUseCase,
    required this.getCarUseCase,
  }) : super(CarInitial());

  /// Easy access object of Cubit
  static CarCubit get(BuildContext context) =>
      BlocProvider.of<CarCubit>(context);

  /// Main fields
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController modelYearController = TextEditingController();
  final TextEditingController currentKmController = TextEditingController();

  final FocusNode carTypeFocus = FocusNode();
  final FocusNode modelYearFocus = FocusNode();
  final FocusNode currentKmFocus = FocusNode();

  Future<void> saveCar(BuildContext context) async {
    emit(CarLoading());

    final car = Car(
      type: carTypeController.text.trim(),
      modelYear: int.parse(modelYearController.text.trim()),
      currentKm: int.parse(currentKmController.text.trim().replaceAll(',', '')),
    );

    final result = await saveCarUseCase(car);

    result.fold(
      (failure) {
        emit(CarError(failure.message));
        BotToast.showText(text: AppStrings.somethingWentWrong(context));
      },
      (success) {
        if (success) {
          emit(CarSaved());
          di.sl<SharedPreferences>().setBool(AppKeys.prefsBoolSeen, true);
          BotToast.showText(text: AppStrings.dataSavedSuccessfully(context));
          navigateToConsumablesScreen(context);
        } else {
          emit(CarError('Failed to save car'));
          BotToast.showText(text: AppStrings.somethingWentWrong(context));
        }
      },
    );
  }

  Future<void> getCar() async {
    emit(CarLoading());

    final result = await getCarUseCase(NoParams());

    result.fold(
      (failure) => emit(CarError(failure.message)),
      (car) => emit(CarLoaded(car)),
    );
  }

  void navigateToConsumablesScreen(BuildContext context) {
    SharedPreferences prefs = di.sl<SharedPreferences>();

    if (prefs.getBool(AppKeys.prefsBoolSeen) ?? false) {
      Navigator.pushReplacementNamed(context, Routes.consumablesRoute);
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }
  }
}
