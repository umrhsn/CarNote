import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/features/my_cars/data/models/car_list_item_model.dart';
import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';

abstract class MyCarsLocalDataSource {
  List<CarListItem> getAllCars();
  CarListItem? getActiveCar();
  Future<bool> addCar(CarListItem car);
  Future<bool> updateCar(CarListItem car);
  Future<bool> deleteCar(String carId);
  Future<bool> setActiveCar(String carId);
  List<CarListItem> searchCars(String query);
}

class MyCarsLocalDataSourceImpl implements MyCarsLocalDataSource {
  final DatabaseService databaseService;

  MyCarsLocalDataSourceImpl({required this.databaseService});

  @override
  List<CarListItem> getAllCars() {
    // This would use a new method in DatabaseService for car list management
    // For now, return empty list as placeholder
    // TODO: Implement car list storage in database service
    return [];
  }

  @override
  CarListItem? getActiveCar() {
    final allCars = getAllCars();
    try {
      return allCars.firstWhere((car) => car.isActive);
    } catch (e) {
      return allCars.isNotEmpty ? allCars.first : null;
    }
  }

  @override
  Future<bool> addCar(CarListItem car) async {
    try {
      // Convert to model and save
      final carModel = CarListItemModel.fromEntity(car);
      // TODO: Implement in database service
      // await databaseService.saveCarListItem(carModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateCar(CarListItem car) async {
    try {
      final carModel = CarListItemModel.fromEntity(car);
      // TODO: Implement in database service
      // await databaseService.updateCarListItem(carModel);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteCar(String carId) async {
    try {
      // TODO: Implement in database service
      // await databaseService.deleteCarListItem(carId);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> setActiveCar(String carId) async {
    try {
      final allCars = getAllCars();
      
      // Deactivate all cars
      for (final car in allCars) {
        final updatedCar = car.copyWith(isActive: false);
        await updateCar(updatedCar);
      }
      
      // Activate the selected car
      final targetCar = allCars.firstWhere((car) => car.id == carId);
      final activeCar = targetCar.copyWith(isActive: true);
      await updateCar(activeCar);
      
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  List<CarListItem> searchCars(String query) {
    final allCars = getAllCars();
    if (query.isEmpty) return allCars;
    
    final lowerQuery = query.toLowerCase();
    return allCars.where((car) =>
      car.name.toLowerCase().contains(lowerQuery) ||
      car.type.toLowerCase().contains(lowerQuery) ||
      car.modelYear.toString().contains(query)
    ).toList();
  }
}
