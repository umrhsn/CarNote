import 'package:car_note/src/features/car_info/domain/entities/consumable.dart';

class ConsumableModel extends Consumable {
  const ConsumableModel({
    required super.id,
    required super.name,
    required super.lastChangedAt,
    required super.changeInterval,
    required super.changeKm,
  });

  factory ConsumableModel.fromDatabaseJson(Map<String, dynamic> data) => ConsumableModel(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a ConsumableModel object
        id: data['id'],
        name: data['name'],
        lastChangedAt: data['lastChangedAt'],
        changeInterval: data['changeInterval'],
        changeKm: data['changeKm'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert ConsumableModel objects that
        //are to be stored into the datbase in a form of JSON
        'id': id,
        'name': name,
        'lastChangedAt': lastChangedAt,
        'changeInterval': changeInterval,
        'changeKm': changeKm,
      };
}
