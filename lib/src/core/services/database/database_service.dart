// lib/src/core/services/database/database_service.dart
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';

abstract class DatabaseService {
  Future<void> init();

  // Car operations
  Future<bool> saveCar(Car car);

  Car? getCar();

  // Consumable operations
  Future<void> saveConsumables(List<Consumable> consumables);

  List<Consumable> getConsumables();

  Future<bool> addConsumable(Consumable consumable);

  void removeConsumable(int index);

  void resetConsumable(int index);

  void resetAllConsumables();

  void removeAllConsumables();

  void reorderConsumables(int oldIndex, int newIndex);

  bool updateConsumableName(int index, String name);
}
