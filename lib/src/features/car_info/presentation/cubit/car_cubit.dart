import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/config/routes/app_routes.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

part 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  CarCubit() : super(CarInitial());

  /// Easy access object of Cubit
  static CarCubit get(BuildContext context) => BlocProvider.of<CarCubit>(context);

  /// Main fields
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController modelYearController = TextEditingController();
  final TextEditingController currentKmController = TextEditingController();

  final FocusNode carTypeFocus = FocusNode();
  final FocusNode modelYearFocus = FocusNode();
  final FocusNode currentKmFocus = FocusNode();

  void navigateToConsumablesScreen(BuildContext context) {
    SharedPreferences prefs = di.sl<SharedPreferences>();

    if (prefs.getBool(AppKeys.prefsBoolSeen) ?? false) {
      Navigator.pushReplacementNamed(context, Routes.consumablesRoute);
    } else {
      BotToast.showText(text: AppStrings.somethingWentWrong(context));
    }
  }
}
