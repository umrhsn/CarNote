import 'package:car_note/src/features/car_info/data/models/car_model.dart';
import 'package:car_note/src/features/consumables/data/models/consumable_model.dart';

abstract class DatabaseService {
  Future<void> init();

  // Car operations
  Future<bool> saveCarModel(CarModel carModel);

  CarModel? getCarModel();

  // Consumable operations
  Future<void> saveConsumableModels(List<ConsumableModel> consumableModels);

  List<ConsumableModel> getConsumableModels();

  Future<bool> addConsumableModel(ConsumableModel consumableModel);

  void removeConsumableModel(int index);

  void resetConsumableModel(int index);

  void resetAllConsumableModels();

  void removeAllConsumableModels();

  void reorderConsumableModels(int oldIndex, int newIndex);

  bool updateConsumableModelName(int index, String name);
}
