import 'package:car_note/src/core/errors/failures.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:dartz/dartz.dart';

abstract class MyCarsRepository {
  Either<Failure, List<CarListItem>> getAllCars();
  Either<Failure, CarListItem?> getActiveCar();
  Future<Either<Failure, bool>> addCar(CarListItem car);
  Future<Either<Failure, bool>> updateCar(CarListItem car);
  Future<Either<Failure, bool>> deleteCar(String carId);
  Future<Either<Failure, bool>> setActiveCar(String carId);
  Either<Failure, List<CarListItem>> searchCars(String query);
}
