// lib/src/features/car_info/domain/repositories/car_repository.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:dartz/dartz.dart';

abstract class CarRepository {
  Future<Either<Failure, bool>> saveCar(Car car);

  Either<Failure, Car?> getCar();
}
