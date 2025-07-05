import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/features/car_info/data/models/car_model.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';

abstract class CarLocalDataSource {
  Future<bool> saveCar(Car car);
  Car? getCar();
}

class CarLocalDataSourceImpl implements CarLocalDataSource {
  final DatabaseService databaseService;

  CarLocalDataSourceImpl({required this.databaseService});

  @override
  Future<bool> saveCar(Car car) async {
    final carModel = CarModel.fromEntity(car);
    return await databaseService.saveCarModel(carModel);
  }

  @override
  Car? getCar() {
    final carModel = databaseService.getCarModel();
    return carModel?.toEntity();
  }
}
