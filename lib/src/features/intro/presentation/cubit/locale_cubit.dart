import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/usecases/usecase.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/intro/domain/usecases/change_lang.dart';
import 'package:car_note/src/features/intro/domain/usecases/get_saved_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  LocaleCubit({required this.getSavedLangUseCase, required this.changeLangUseCase}) : super(const ChangeLocaleState(Locale(AppStrings.en)));

  /// Easy access object of Cubit
  static LocaleCubit get(BuildContext context) => BlocProvider.of<LocaleCubit>(context);

  static String currentLangCode = AppStrings.en;

  Future<String> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
    return currentLangCode;
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  void toEnglish(BuildContext context, {required bool showToast}) {
    _changeLang(AppStrings.en).then((value) {
      if (showToast) BotToast.showText(text: AppStrings.langChangedToast(context));
    });
  }

  void toArabic(BuildContext context, {required bool showToast}) {
    _changeLang(AppStrings.ar).then((value) {
      if (showToast) BotToast.showText(text: AppStrings.langChangedToast(context));
    });
  }
}
