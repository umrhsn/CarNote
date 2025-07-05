// lib/injection_container.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/core/services/database/hive_database_service.dart';
import 'package:car_note/src/core/services/file/file_service.dart';
import 'package:car_note/src/core/services/file/file_service_impl.dart';
import 'package:car_note/src/core/services/notification/notification_service.dart';
import 'package:car_note/src/core/services/notification/notification_service_impl.dart';
import 'package:dartz/dartz.dart';

// Car Info Feature
import 'package:car_note/src/features/car_info/data/data_sources/car_local_data_source.dart';
import 'package:car_note/src/features/car_info/data/repositories/car_repository_impl.dart';
import 'package:car_note/src/features/car_info/domain/repositories/car_repository.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/get_car_use_case.dart';
import 'package:car_note/src/features/car_info/domain/use_cases/save_car_use_case.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';

// Consumables Feature
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

// Info Feature
import 'package:car_note/src/features/info/data/data_sources/info_local_data_source.dart';
import 'package:car_note/src/features/info/domain/entities/dashboard_item.dart';
import 'package:car_note/src/features/info/domain/repositories/info_repository.dart';
import 'package:car_note/src/features/info/domain/use_cases/get_dashboard_items_use_case.dart';
import 'package:car_note/src/features/info/domain/use_cases/search_dashboard_items_use_case.dart';
import 'package:car_note/src/features/info/presentation/cubit/info_cubit.dart';

// MyCars Feature
import 'package:car_note/src/features/my_cars/data/data_sources/my_cars_local_data_source.dart';
import 'package:car_note/src/features/my_cars/data/repositories/my_cars_repository_impl.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/add_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/delete_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/get_active_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/get_all_cars_use_case.dart';
import 'package:car_note/src/features/my_cars/presentation/cubit/my_cars_cubit.dart';

// Intro Feature (Language)
import 'package:car_note/src/features/intro/data/data_sources/lang_local_data_source.dart';
import 'package:car_note/src/features/intro/data/repositories/lang_repository_impl.dart';
import 'package:car_note/src/features/intro/domain/repositories/lang_repository.dart';
import 'package:car_note/src/features/intro/domain/use_cases/change_lang_use_case.dart';
import 'package:car_note/src/features/intro/domain/use_cases/get_saved_lang_use_case.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';

// External Dependencies
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance; // service locator instance

Future<void> init() async {
  // ========================================
  // FEATURES
  // ========================================

  await _initCarInfoFeature();
  await _initConsumablesFeature();
  await _initInfoFeature();
  await _initMyCarsFeature();
  await _initIntroFeature();

  // ========================================
  // CORE SERVICES
  // ========================================

  await _initCoreServices();

  // ========================================
  // EXTERNAL DEPENDENCIES
  // ========================================

  await _initExternalDependencies();
}

// ========================================
// CAR INFO FEATURE
// ========================================
Future<void> _initCarInfoFeature() async {
  // Cubits
  sl.registerFactory<CarCubit>(
    () => CarCubit(
      saveCarUseCase: sl(),
      getCarUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<SaveCarUseCase>(
    () => SaveCarUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetCarUseCase>(
    () => GetCarUseCase(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<CarLocalDataSource>(
    () => CarLocalDataSourceImpl(databaseService: sl()),
  );
}

// ========================================
// CONSUMABLES FEATURE
// ========================================
Future<void> _initConsumablesFeature() async {
  // Cubits
  sl.registerFactory<ConsumableCubit>(
    () => ConsumableCubit(
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
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetConsumablesUseCase>(
    () => GetConsumablesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SaveConsumablesUseCase>(
    () => SaveConsumablesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<AddConsumableUseCase>(
    () => AddConsumableUseCase(repository: sl()),
  );

  sl.registerLazySingleton<RemoveConsumableUseCase>(
    () => RemoveConsumableUseCase(repository: sl()),
  );

  sl.registerLazySingleton<ResetConsumableUseCase>(
    () => ResetConsumableUseCase(repository: sl()),
  );

  sl.registerLazySingleton<ResetAllConsumablesUseCase>(
    () => ResetAllConsumablesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<RemoveAllConsumablesUseCase>(
    () => RemoveAllConsumablesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<ReorderConsumablesUseCase>(
    () => ReorderConsumablesUseCase(repository: sl()),
  );

  sl.registerLazySingleton<UpdateConsumableNameUseCase>(
    () => UpdateConsumableNameUseCase(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ConsumableRepository>(
    () => ConsumableRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<ConsumableLocalDataSource>(
    () => ConsumableLocalDataSourceImpl(databaseService: sl()),
  );
}

// ========================================
// INFO FEATURE (Dashboard)
// ========================================
Future<void> _initInfoFeature() async {
  // Cubits
  sl.registerFactory<InfoCubit>(
    () => InfoCubit(
      getDashboardItemsUseCase: sl(),
      searchDashboardItemsUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetDashboardItemsUseCase>(
    () => GetDashboardItemsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<SearchDashboardItemsUseCase>(
    () => SearchDashboardItemsUseCase(repository: sl()),
  );

  // Repositories - Register the wrapper that handles context
  sl.registerLazySingleton<InfoRepository>(
    () => InfoRepositoryContextWrapper(
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<InfoLocalDataSource>(
    () => InfoLocalDataSourceImpl(),
  );
}

// ========================================
// MY CARS FEATURE
// ========================================
Future<void> _initMyCarsFeature() async {
  // Cubits
  sl.registerFactory<MyCarsCubit>(
    () => MyCarsCubit(
      getAllCarsUseCase: sl(),
      getActiveCarUseCase: sl(),
      addCarUseCase: sl(),
      deleteCarUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetAllCarsUseCase>(
    () => GetAllCarsUseCase(repository: sl()),
  );

  sl.registerLazySingleton<GetActiveCarUseCase>(
    () => GetActiveCarUseCase(repository: sl()),
  );

  sl.registerLazySingleton<AddCarUseCase>(
    () => AddCarUseCase(repository: sl()),
  );

  sl.registerLazySingleton<DeleteCarUseCase>(
    () => DeleteCarUseCase(repository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<MyCarsRepository>(
    () => MyCarsRepositoryImpl(localDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<MyCarsLocalDataSource>(
    () => MyCarsLocalDataSourceImpl(databaseService: sl()),
  );
}

// ========================================
// INTRO FEATURE (Language/Localization)
// ========================================
Future<void> _initIntroFeature() async {
  // Cubits
  sl.registerFactory<LocaleCubit>(
    () => LocaleCubit(
      getSavedLangUseCase: sl(),
      changeLangUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<GetSavedLangUseCase>(
    () => GetSavedLangUseCase(langRepository: sl()),
  );

  sl.registerLazySingleton<ChangeLangUseCase>(
    () => ChangeLangUseCase(langRepository: sl()),
  );

  // Repositories
  sl.registerLazySingleton<LangRepository>(
    () => LangRepositoryImpl(langLocalDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<LangLocalDataSource>(
    () => LangLocalDataSourceImpl(sharedPreferences: sl()),
  );
}

// ========================================
// CORE SERVICES
// ========================================
Future<void> _initCoreServices() async {
  // Database Service
  sl.registerLazySingleton<DatabaseService>(
    () => HiveDatabaseService(sharedPreferences: sl()),
  );

  // File Service
  sl.registerLazySingleton<FileService>(
    () => FileServiceImpl(fileSaver: FileSaver.instance),
  );

  // Notification Service
  sl.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(),
  );
}

// ========================================
// EXTERNAL DEPENDENCIES
// ========================================
Future<void> _initExternalDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

// ========================================
// HELPER CLASSES
// ========================================

/// Wrapper class to handle BuildContext dependency for InfoRepository
/// This allows us to inject InfoRepository without requiring BuildContext at registration time
class InfoRepositoryContextWrapper implements InfoRepository {
  final InfoLocalDataSource localDataSource;

  InfoRepositoryContextWrapper({required this.localDataSource});

  @override
  Either<Failure, List<DashboardItem>> getDashboardItems() {
    // This method should not be called directly - use cubit methods instead
    return Left(DatabaseFailure(
        'Use InfoCubit methods instead of direct repository calls'));
  }

  @override
  Either<Failure, List<DashboardItem>> getDashboardItemsByCategory(
      int category) {
    return Left(DatabaseFailure(
        'Use InfoCubit methods instead of direct repository calls'));
  }

  @override
  Either<Failure, List<DashboardItem>> searchDashboardItems(String query) {
    return Left(DatabaseFailure(
        'Use InfoCubit methods instead of direct repository calls'));
  }

  @override
  Either<Failure, List<DashboardItem>> sortDashboardItems(
      List<DashboardItem> items, String sortBy) {
    try {
      final sortedItems = localDataSource.sortDashboardItems(items, sortBy);
      return Right(sortedItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to sort dashboard items'));
    }
  }

  // Context-aware methods to be used by the cubit
  Either<Failure, List<DashboardItem>> getDashboardItemsWithContext(
      BuildContext context) {
    try {
      final dashboardItems = localDataSource.getDashboardItems(context);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get dashboard items'));
    }
  }

  Either<Failure, List<DashboardItem>> getDashboardItemsByCategoryWithContext(
      BuildContext context, int category) {
    try {
      final dashboardItems =
          localDataSource.getDashboardItemsByCategory(context, category);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get dashboard items by category'));
    }
  }

  Either<Failure, List<DashboardItem>> searchDashboardItemsWithContext(
      BuildContext context, String query) {
    try {
      final dashboardItems =
          localDataSource.searchDashboardItems(context, query);
      return Right(dashboardItems);
    } catch (e) {
      return Left(DatabaseFailure('Failed to search dashboard items'));
    }
  }
}

// ========================================
// HELPER FUNCTIONS
// ========================================

/// Reset all dependencies (useful for testing)
Future<void> resetDependencies() async {
  await sl.reset();
}

/// Get a dependency (with type safety)
T getDependency<T extends Object>() {
  return sl.get<T>();
}

/// Check if a dependency is registered
bool isDependencyRegistered<T extends Object>() {
  return sl.isRegistered<T>();
}

/// Register a mock dependency (useful for testing)
void registerMockDependency<T extends Object>(T mockInstance) {
  if (sl.isRegistered<T>()) {
    sl.unregister<T>();
  }
  sl.registerSingleton<T>(mockInstance);
}

// ========================================
// DEPENDENCY VALIDATION
// ========================================

/// Validate that all required dependencies are registered
/// This helps catch missing registrations early
void validateDependencies() {
  final requiredTypes = <Type>[
    // Core Services
    DatabaseService,
    FileService,
    NotificationService,
    SharedPreferences,

    // Car Info
    CarCubit,
    CarRepository,
    CarLocalDataSource,
    SaveCarUseCase,
    GetCarUseCase,

    // Consumables
    ConsumableCubit,
    ConsumableRepository,
    ConsumableLocalDataSource,
    GetConsumablesUseCase,
    SaveConsumablesUseCase,
    AddConsumableUseCase,

    // Info
    InfoCubit,
    InfoRepository,
    InfoLocalDataSource,
    GetDashboardItemsUseCase,
    SearchDashboardItemsUseCase,

    // MyCars
    MyCarsCubit,
    MyCarsRepository,
    MyCarsLocalDataSource,
    GetAllCarsUseCase,
    AddCarUseCase,

    // Intro
    LocaleCubit,
    LangRepository,
    LangLocalDataSource,
    GetSavedLangUseCase,
    ChangeLangUseCase,
  ];

  final missingTypes = <Type>[];

  for (final type in requiredTypes) {
    if (!sl.isRegistered(instance: type)) {
      missingTypes.add(type);
    }
  }

  if (missingTypes.isNotEmpty) {
    throw Exception(
        'Missing dependency registrations: ${missingTypes.map((t) => t.toString()).join(', ')}');
  }
}

// ========================================
// INITIALIZATION STATUS
// ========================================

bool _isInitialized = false;

bool get isInitialized => _isInitialized;

Future<void> ensureInitialized() async {
  if (!_isInitialized) {
    await init();
    validateDependencies();
    _isInitialized = true;
  }
}
