// lib/src/features/car_info/domain/use_cases/save_car_use_case.dart
import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/domain/repositories/car_repository.dart';
import 'package:dartz/dartz.dart';

class SaveCarUseCase implements UseCase<bool, Car> {
  final CarRepository repository;

  SaveCarUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(Car params) async {
    return await repository.saveCar(params);
  }
}