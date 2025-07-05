import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/core/use_cases/use_case.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:car_note/src/features/my_cars/domain/repositories/my_cars_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllCarsUseCase implements UseCase<List<CarListItem>, NoParams> {
  final MyCarsRepository repository;

  GetAllCarsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<CarListItem>>> call(NoParams params) async {
    return Future.value(repository.getAllCars());
  }
}
