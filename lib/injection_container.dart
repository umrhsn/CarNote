// lib/injection_container.dart
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/core/services/database/hive_database_service.dart';
import 'package:car_note/src/core/services/file/file_service.dart';
import 'package:car_note/src/core/services/file/file_service_impl.dart';
import 'package:car_note/src/core/services/notification/notification_service.dart';
import 'package:car_note/src/core/services/notification/notification_service_impl.dart';
import 'package:car_note/src/features/car_info/data/data_sources/car_local_data_source.dart';
import 'package:car_note/src/features/car_info/data/repositories/car_repository_impl.dart';
import 'package:car_note/src/features/car_info/domain/repositories/car_repository.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/get_car_use_case.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/save_car_use_case.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/data/data_sources/consumable_local_data_source.dart';
import 'package:car_note/src/features/consumables/data/repositories/consumable_repository_impl.dart';
import 'package:car_note/src/features/consumables/domain/repositories/consumable_repository.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/add_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/get_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/remove_all_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/remove_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reorder_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reset_all_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/reset_consumable_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/save_consumables_use_case.dart';
import 'package:car_note/src/features/consumables/domain/use_cases/update_consumable_name_use_case.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/data/data_sources/lang_local_data_source.dart';
import 'package:car_note/src/features/intro/data/repositories/lang_repository_impl.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:car_note/src/features/intro/domain/use_cases/change_lang_use_case.dart';
import 'package:car_note/src/features/intro/domain/use_cases/get_saved_lang_use_case.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:file_saver/file_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance; // service locator instance

Future<void> init() async {
  /* Features */

  /// Cubits
  sl.registerFactory<LocaleCubit>(
      () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  sl.registerFactory<CarCubit>(
      () => CarCubit(saveCarUseCase: sl(), getCarUseCase: sl()));

  sl.registerFactory<ConsumableCubit>(() => ConsumableCubit(
        getConsumablesUseCase: sl(),
        saveConsumablesUseCase: sl(),
        addConsumableUseCase: sl(),
        removeConsumableUseCase: sl(),
        resetConsumableUseCase: sl(),
        resetAllConsumablesUseCase: sl(),
        removeAllConsumablesUseCase: sl(),
        reorderConsumablesUseCase: sl(),
        updateConsumableNameUseCase: sl(),
        getCarUseCase: sl(),
        saveCarUseCase: sl(),
      ));

  /// Use Cases - Car
  sl.registerLazySingleton<SaveCarUseCase>(
      () => SaveCarUseCase(repository: sl()));
  sl.registerLazySingleton<GetCarUseCase>(
      () => GetCarUseCase(repository: sl()));

  /// Use Cases - Consumables
  sl.registerLazySingleton<GetConsumablesUseCase>(
      () => GetConsumablesUseCase(repository: sl()));
  sl.registerLazySingleton<SaveConsumablesUseCase>(
      () => SaveConsumablesUseCase(repository: sl()));
  sl.registerLazySingleton<AddConsumableUseCase>(
      () => AddConsumableUseCase(repository: sl()));
  sl.registerLazySingleton<RemoveConsumableUseCase>(
      () => RemoveConsumableUseCase(repository: sl()));
  sl.registerLazySingleton<ResetConsumableUseCase>(
      () => ResetConsumableUseCase(repository: sl()));
  sl.registerLazySingleton<ResetAllConsumablesUseCase>(
      () => ResetAllConsumablesUseCase(repository: sl()));
  sl.registerLazySingleton<RemoveAllConsumablesUseCase>(
      () => RemoveAllConsumablesUseCase(repository: sl()));
  sl.registerLazySingleton<ReorderConsumablesUseCase>(
      () => ReorderConsumablesUseCase(repository: sl()));
  sl.registerLazySingleton<UpdateConsumableNameUseCase>(
      () => UpdateConsumableNameUseCase(repository: sl()));

  /// Use Cases - Language
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));

  /// Repositories
  sl.registerLazySingleton<CarRepository>(
      () => CarRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<ConsumableRepository>(
      () => ConsumableRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));

  /// Data Sources
  sl.registerLazySingleton<CarLocalDataSource>(
      () => CarLocalDataSourceImpl(databaseService: sl()));
  sl.registerLazySingleton<ConsumableLocalDataSource>(
      () => ConsumableLocalDataSourceImpl(databaseService: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  /* =========================================================================================== */
  /* Core Services */

  /// Database Service
  sl.registerLazySingleton<DatabaseService>(
      () => HiveDatabaseService(sharedPreferences: sl()));

  /// File Service
  sl.registerLazySingleton<FileService>(
      () => FileServiceImpl(fileSaver: FileSaver.instance));

  /// Notification Service
  sl.registerLazySingleton<NotificationService>(
      () => NotificationServiceImpl());

  /* =========================================================================================== */
  /* External */

  /// SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
