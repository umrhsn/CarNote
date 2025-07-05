// Bridge class for backward compatibility during migration
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/features/car_info/data/models/car_model.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/data/models/consumable_model.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/injection_container.dart' as di;

/// Bridge class to gradually migrate from DatabaseHelper to new architecture
/// This provides backward compatibility while moving to clean architecture
class DatabaseHelperBridge {
  static final DatabaseService _databaseService = di.sl<DatabaseService>();

  // Car operations
  static Future<bool> writeCarData(Car car) async {
    final carModel = CarModel.fromEntity(car);
    return await _databaseService.saveCarModel(carModel);
  }

  static Car? getCar() {
    final carModel = _databaseService.getCarModel();
    return carModel?.toEntity();
  }

  // Consumable operations
  static List<Consumable> getConsumables() {
    final models = _databaseService.getConsumableModels();
    return models.map((model) => model.toEntity()).toList();
  }

  static Future<void> saveConsumables(List<Consumable> consumables) async {
    final models = consumables.map((e) => ConsumableModel.fromEntity(e)).toList();
    await _databaseService.saveConsumableModels(models);
  }

  static Future<bool> addConsumable(Consumable consumable) async {
    final model = ConsumableModel.fromEntity(consumable);
    return await _databaseService.addConsumableModel(model);
  }

  static void removeConsumable(int index) {
    _databaseService.removeConsumableModel(index);
  }

  static void resetConsumable(int index) {
    _databaseService.resetConsumableModel(index);
  }

  static void resetAllConsumables() {
    _databaseService.resetAllConsumableModels();
  }

  static void removeAllConsumables() {
    _databaseService.removeAllConsumableModels();
  }

  static void reorderConsumables(int oldIndex, int newIndex) {
    _databaseService.reorderConsumableModels(oldIndex, newIndex);
  }

  static bool updateConsumableName(int index, String name) {
    return _databaseService.updateConsumableModelName(index, name);
  }

  // Helper method to get consumable count
  static int getConsumableCount() {
    return getConsumables().length;
  }
}
