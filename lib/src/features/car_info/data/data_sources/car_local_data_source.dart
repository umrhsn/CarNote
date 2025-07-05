// lib/src/features/car_info/data/data_sources/car_local_data_source.dart
import 'package:car_note/src/core/services/database/database_service.dart';
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
    return await databaseService.saveCar(car);
  }

  @override
  Car? getCar() {
    return databaseService.getCar();
  }
}
