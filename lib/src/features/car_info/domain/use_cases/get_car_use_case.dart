// lib/src/features/car_info/domain/use_cases/get_car_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/repositories/car_repository.dart';
import 'package:dartz/dartz.dart';

class GetCarUseCase implements UseCase<Car?, NoParams> {
  final CarRepository repository;

  GetCarUseCase({required this.repository});

  @override
  Future<Either<Failure, Car?>> call(NoParams params) async {
    return Future.value(repository.getCar());
  }
}
