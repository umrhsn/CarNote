import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/data/data_sources/lang_local_data_source.dart';
import 'package:car_note/src/features/intro/data/repositories/lang_repository_impl.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:car_note/src/features/intro/domain/usecases/change_lang.dart';
import 'package:car_note/src/features/intro/domain/usecases/get_saved_lang.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance; // service locator instance

Future<void> init() async {
  /* Features */

  /// Cubits
  sl.registerFactory<LocaleCubit>(() => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));
  sl.registerFactory<CarCubit>(() => CarCubit());
  sl.registerFactory<ConsumableCubit>(() => ConsumableCubit());

  /// Use Cases
  sl.registerLazySingleton<GetSavedLangUseCase>(() => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(() => ChangeLangUseCase(langRepository: sl()));

  /// Repositories
  sl.registerLazySingleton<LangRepository>(() => LangRepositoryImpl(langLocalDataSource: sl()));

  /// Data Sources
  sl.registerLazySingleton<LangLocalDataSource>(() => LangLocalDataSourceImpl(sharedPreferences: sl()));

  /* =========================================================================================== */
  /* External */

  /// SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
