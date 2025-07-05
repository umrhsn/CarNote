import 'package:car_note/src/core/services/database/database_service.dart';
import 'package:car_note/src/features/consumables/data/models/consumable_model.dart';
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
    final consumableModels =
        consumables.map((e) => ConsumableModel.fromEntity(e)).toList();
    await databaseService.saveConsumableModels(consumableModels);
  }

  @override
  List<Consumable> getConsumables() {
    final consumableModels = databaseService.getConsumableModels();
    return consumableModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<bool> addConsumable(Consumable consumable) async {
    final consumableModel = ConsumableModel.fromEntity(consumable);
    return await databaseService.addConsumableModel(consumableModel);
  }

  @override
  void removeConsumable(int index) {
    databaseService.removeConsumableModel(index);
  }

  @override
  void resetConsumable(int index) {
    databaseService.resetConsumableModel(index);
  }

  @override
  void resetAllConsumables() {
    databaseService.resetAllConsumableModels();
  }

  @override
  void removeAllConsumables() {
    databaseService.removeAllConsumableModels();
  }

  @override
  void reorderConsumables(int oldIndex, int newIndex) {
    databaseService.reorderConsumableModels(oldIndex, newIndex);
  }

  @override
  bool updateConsumableName(int index, String name) {
    return databaseService.updateConsumableModelName(index, name);
  }
}
