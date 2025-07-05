import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:hive/hive.dart';

part 'consumable_model.g.dart';

@HiveType(typeId: 2)
class ConsumableModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final int lastChangedAt;

  @HiveField(3)
  final int changeInterval;

  @HiveField(4)
  final int remainingKm;

  ConsumableModel({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.remainingKm,
  });

  // Convert from domain entity to data model
  factory ConsumableModel.fromEntity(Consumable consumable) {
    return ConsumableModel(
      id: consumable.id,
      name: consumable.name,
      lastChangedAt: consumable.lastChangedAt,
      changeInterval: consumable.changeInterval,
      remainingKm: consumable.remainingKm,
    );
  }

  // Convert from data model to domain entity
  Consumable toEntity() {
    return Consumable(
      id: id,
      name: name,
      lastChangedAt: lastChangedAt,
      changeInterval: changeInterval,
      remainingKm: remainingKm,
    );
  }

  // For JSON serialization (if needed for API calls)
  factory ConsumableModel.fromJson(Map<String, dynamic> json) {
    return ConsumableModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      lastChangedAt: json['lastChangedAt'] ?? 0,
      changeInterval: json['changeInterval'] ?? 0,
      remainingKm: json['remainingKm'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastChangedAt': lastChangedAt,
      'changeInterval': changeInterval,
      'remainingKm': remainingKm,
    };
  }

  // Create a copy with updated values
  ConsumableModel copyWith({
    int? id,
    String? name,
    int? lastChangedAt,
    int? changeInterval,
    int? remainingKm,
  }) {
    return ConsumableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      lastChangedAt: lastChangedAt ?? this.lastChangedAt,
      changeInterval: changeInterval ?? this.changeInterval,
      remainingKm: remainingKm ?? this.remainingKm,
    );
  }

  @override
  String toString() {
    return 'ConsumableModel(id: $id, name: $name, lastChangedAt: $lastChangedAt, changeInterval: $changeInterval, remainingKm: $remainingKm)';
  }
}
