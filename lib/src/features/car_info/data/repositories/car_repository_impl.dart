// lib/src/features/car_info/data/repositories/car_repository_impl.dart
import 'package:car_note/src/core/errors/exceptions.dart';
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/car_info/data/data_sources/car_local_data_source.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/repositories/car_repository.dart';
import 'package:dartz/dartz.dart';

class CarRepositoryImpl implements CarRepository {
  final CarLocalDataSource localDataSource;

  CarRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> saveCar(Car car) async {
    try {
      final result = await localDataSource.saveCar(car);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to save car'));
    } catch (e) {
      return Left(
          DatabaseFailure('Unexpected error occurred while saving car'));
    }
  }

  @override
  Either<Failure, Car?> getCar() {
    try {
      final car = localDataSource.getCar();
      return Right(car);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message ?? 'Failed to get car'));
    } catch (e) {
      return Left(
          DatabaseFailure('Unexpected error occurred while getting car'));
    }
  }
}
