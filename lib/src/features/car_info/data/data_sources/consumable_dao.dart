import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/data/data_sources/database.dart';
import 'package:car_note/src/features/car_info/data/models/consumable_model.dart';

class ConsumableDao {
  final dbProvider = DatabaseProvider.dbProvider;

  // Adds new Consumable records
  Future<int> createConsumable(ConsumableModel consumable) async {
    final db = await dbProvider.database;
    var result = db.insert(AppStrings.consumablesTable, consumable.toDatabaseJson());
    return result;
  }

  // Get all Consumable items
  Future<List<ConsumableModel>> getAllConsumables({List<String>? columns}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result = [];
    result = await db.query(AppStrings.consumablesTable, columns: columns);

    List<ConsumableModel> consumables = result.isNotEmpty
        ? result.map((item) => ConsumableModel.fromDatabaseJson(item)).toList()
        : [];

    return consumables;
  }

  //Update a Consumable record
  Future<int> updateConsumable(ConsumableModel consumable) async {
    final db = await dbProvider.database;

    var result = await db.update(AppStrings.consumablesTable, consumable.toDatabaseJson(),
        where: "id = ?", whereArgs: [consumable.id]);

    return result;
  }

  // Delete a Consumable record
  Future<int> deleteConsumable(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(AppStrings.consumablesTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // Delete all Consumable records
  Future<int> deleteAllConsumables() async {
    final db = await dbProvider.database;
    var result = await db.delete(AppStrings.consumablesTable);
    return result;
  }
}
