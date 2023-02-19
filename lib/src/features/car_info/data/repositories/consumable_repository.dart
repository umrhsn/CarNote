import 'package:car_note/src/features/car_info/data/data_sources/consumable_dao.dart';
import 'package:car_note/src/features/car_info/data/models/consumable_model.dart';

class ConsumableRepository {
  final consumableDao = ConsumableDao();

  Future<List<ConsumableModel>> getAllConsumables() => consumableDao.getAllConsumables();

  Future<int> insertConsumable(ConsumableModel consumable) => consumableDao.createConsumable(consumable);

  Future<int> updateConsumable(ConsumableModel consumable) => consumableDao.updateConsumable(consumable);

  Future<int> deleteConsumableById(int id) => consumableDao.deleteConsumable(id);

  Future<int> deleteAllConsumables() => consumableDao.deleteAllConsumables();
}
