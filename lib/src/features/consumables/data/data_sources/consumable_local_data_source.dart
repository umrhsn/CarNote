// lib/src/features/consumables/data/data_sources/consumable_local_data_source.dart
import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';

abstract class ConsumableLocalDataSource {
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

class ConsumableLocalDataSourceImpl implements ConsumableLocalDataSource {
  final DatabaseService databaseService;

  ConsumableLocalDataSourceImpl({required this.databaseService});

  @override
  Future<void> saveConsumables(List<Consumable> consumables) async {
    await databaseService.saveConsumables(consumables);
  }

  @override
  List<Consumable> getConsumables() {
    return databaseService.getConsumables();
  }

  @override
  Future<bool> addConsumable(Consumable consumable) async {
    return await databaseService.addConsumable(consumable);
  }

  @override
  void removeConsumable(int index) {
    databaseService.removeConsumable(index);
  }

  @override
  void resetConsumable(int index) {
    databaseService.resetConsumable(index);
  }

  @override
  void resetAllConsumables() {
    databaseService.resetAllConsumables();
  }

  @override
  void removeAllConsumables() {
    databaseService.removeAllConsumables();
  }

  @override
  void reorderConsumables(int oldIndex, int newIndex) {
    databaseService.reorderConsumables(oldIndex, newIndex);
  }

  @override
  bool updateConsumableName(int index, String name) {
    return databaseService.updateConsumableName(index, name);
  }
}
