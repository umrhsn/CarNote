import 'package:bot_toast/bot_toast.dart';
import 'package:car_note/src/core/usecases/usecase.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/splash/domain/usecases/change_lang.dart';
import 'package:car_note/src/features/splash/domain/usecases/get_saved_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:car_note/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  LocaleCubit({required this.getSavedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocaleState(Locale(AppStrings.en)));

  /// Easy access object of Cubit
  static LocaleCubit get(BuildContext context) => BlocProvider.of<LocaleCubit>(context);

  String currentLangCode = AppStrings.en;
  bool listArabic = di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolListArabic) ?? false;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      emit(ChangeLocaleState(Locale(currentLangCode)));
    });
  }

  bool _changeListLanguage(bool arabic) {
    SharedPreferences prefs = di.sl<SharedPreferences>();
    if (prefs.getBool(AppStrings.prefsBoolListArabic) == null) {
      prefs.setBool(AppStrings.prefsBoolListArabic, arabic);
    }
    bool isArabic = prefs.getBool(AppStrings.prefsBoolListArabic) ?? false;
    emit(ChangeLocaleState(Locale(currentLangCode)));
    return isArabic;
  }

  void toEnglish(BuildContext context) {
    _changeListLanguage(false);
    _changeLang(AppStrings.en)
        .then((value) => BotToast.showText(text: AppStrings.langChangedToast(context)));
  }

  void toArabic(BuildContext context) {
    _changeListLanguage(true);
    _changeLang(AppStrings.ar)
        .then((value) => BotToast.showText(text: AppStrings.langChangedToast(context)));
  }
}
