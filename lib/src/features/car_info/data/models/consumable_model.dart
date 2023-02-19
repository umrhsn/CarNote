import 'package:car_note/src/features/car_info/domain/entities/consumable.dart';

class ConsumableModel extends Consumable {
  const ConsumableModel({
    required super.id,
    required super.name,
    required super.lastChangedAt,
    required super.changeInterval,
    required super.changeKm,
  });

  factory ConsumableModel.fromJson(Map<String, dynamic> json) {
    return ConsumableModel(
      id: json['id'],
      name: json['name'],
      lastChangedAt: json['lastChangedAt'],
      changeInterval: json['changeInterval'],
      changeKm: json['changeKm'],
    );
  }
}
