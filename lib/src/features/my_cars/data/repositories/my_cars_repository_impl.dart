import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/my_cars/data/data_sources/my_cars_local_data_source.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:dartz/dartz.dart';

class MyCarsRepositoryImpl implements MyCarsRepository {
  final MyCarsLocalDataSource localDataSource;

  MyCarsRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, List<CarListItem>> getAllCars() {
    try {
      final cars = localDataSource.getAllCars();
      return Right(cars);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get all cars'));
    }
  }

  @override
  Either<Failure, CarListItem?> getActiveCar() {
    try {
      final activeCar = localDataSource.getActiveCar();
      return Right(activeCar);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get active car'));
    }
  }

  @override
  Future<Either<Failure, bool>> addCar(CarListItem car) async {
    try {
      final result = await localDataSource.addCar(car);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add car'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateCar(CarListItem car) async {
    try {
      final result = await localDataSource.updateCar(car);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update car'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCar(String carId) async {
    try {
      final result = await localDataSource.deleteCar(carId);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete car'));
    }
  }

  @override
  Future<Either<Failure, bool>> setActiveCar(String carId) async {
    try {
      final result = await localDataSource.setActiveCar(carId);
      return Right(result);
    } catch (e) {
      return Left(DatabaseFailure('Failed to set active car'));
    }
  }

  @override
  Either<Failure, List<CarListItem>> searchCars(String query) {
    try {
      final cars = localDataSource.searchCars(query);
      return Right(cars);
    } catch (e) {
      return Left(DatabaseFailure('Failed to search cars'));
    }
  }
}
