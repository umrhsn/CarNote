import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance; // service locator instance

Future<void> init() async {
  /// features
  // cubits
  sl.registerFactory<CarCubit>(() => CarCubit());

  sl.registerFactory<ConsumableCubit>(() => ConsumableCubit());

  /// ===========================================================================================
  /// external
  // shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
