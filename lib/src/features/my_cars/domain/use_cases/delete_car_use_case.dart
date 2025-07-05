import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteCarUseCase implements UseCase<bool, String> {
  final MyCarsRepository repository;

  DeleteCarUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return await repository.deleteCar(params);
  }
}
