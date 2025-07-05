import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:dartz/dartz.dart';

class AddCarUseCase implements UseCase<bool, CarListItem> {
  final MyCarsRepository repository;

  AddCarUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(CarListItem params) async {
    return await repository.addCar(params);
  }
}
