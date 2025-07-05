import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/add_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/delete_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/get_active_car_use_case.dart';
import 'package:car_note/src/features/my_cars/domain/use_cases/get_all_cars_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'my_cars_state.dart';

class MyCarsCubit extends Cubit<MyCarsState> {
  final GetAllCarsUseCase getAllCarsUseCase;
  final GetActiveCarUseCase getActiveCarUseCase;
  final AddCarUseCase addCarUseCase;
  final DeleteCarUseCase deleteCarUseCase;

  MyCarsCubit({
    required this.getAllCarsUseCase,
    required this.getActiveCarUseCase,
    required this.addCarUseCase,
    required this.deleteCarUseCase,
  }) : super(MyCarsInitial());

  static MyCarsCubit get(BuildContext context) => BlocProvider.of<MyCarsCubit>(context);

  List<CarListItem> _cars = [];
  CarListItem? _activeCar;

  List<CarListItem> get cars => _cars;
  CarListItem? get activeCar => _activeCar;

  Future<void> loadCars() async {
    emit(MyCarsLoading());

    final result = await getAllCarsUseCase(NoParams());
    result.fold(
      (failure) => emit(MyCarsError(failure.message)),
      (cars) {
        _cars = cars;
        emit(MyCarsLoaded(cars));
        _loadActiveCar();
      },
    );
  }

  Future<void> _loadActiveCar() async {
    final result = await getActiveCarUseCase(NoParams());
    result.fold(
      (failure) => {}, // Don't emit error for active car, just continue
      (activeCar) {
        _activeCar = activeCar;
        emit(MyCarsActiveCarLoaded(activeCar));
      },
    );
  }

  Future<void> addCar(CarListItem car) async {
    emit(MyCarsAdding());

    final result = await addCarUseCase(car);
    result.fold(
      (failure) => emit(MyCarsError(failure.message)),
      (success) {
        if (success) {
          _cars.add(car);
          emit(MyCarsCarAdded(car));
          loadCars(); // Reload to get updated list
        } else {
          emit(MyCarsError('Failed to add car'));
        }
      },
    );
  }

  Future<void> deleteCar(String carId) async {
    emit(MyCarsDeleting());

    final result = await deleteCarUseCase(carId);
    result.fold(
      (failure) => emit(MyCarsError(failure.message)),
      (success) {
        if (success) {
          _cars.removeWhere((car) => car.id == carId);
          if (_activeCar?.id == carId) {
            _activeCar = null;
          }
          emit(MyCarsCarDeleted(carId));
          loadCars(); // Reload to get updated list
        } else {
          emit(MyCarsError('Failed to delete car'));
        }
      },
    );
  }

  void selectCar(CarListItem car) {
    emit(MyCarsCarSelected(car));
  }

  CarListItem? findCarById(String carId) {
    try {
      return _cars.firstWhere((car) => car.id == carId);
    } catch (e) {
      return null;
    }
  }
}
