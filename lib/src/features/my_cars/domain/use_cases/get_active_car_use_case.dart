import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:dartz/dartz.dart';

class GetActiveCarUseCase implements UseCase<CarListItem?, NoParams> {
  final MyCarsRepository repository;

  GetActiveCarUseCase({required this.repository});

  @override
  Future<Either<Failure, CarListItem?>> call(NoParams params) async {
    return Future.value(repository.getActiveCar());
  }
}
