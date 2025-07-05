import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consumable_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ConsumableModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;
  
  @HiveField(1)
  @JsonKey(name: 'name')
  String name;
  
  @HiveField(2)
  @JsonKey(name: 'lastChangedAt')
  final int lastChangedAt;
  
  @HiveField(3)
  @JsonKey(name: 'changeInterval')
  final int changeInterval;
  
  @HiveField(4)
  @JsonKey(name: 'remainingKm')
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

  // JSON serialization
  factory ConsumableModel.fromJson(Map<String, dynamic> json) => _$ConsumableModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConsumableModelToJson(this);

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConsumableModel &&
        other.id == id &&
        other.name == name &&
        other.lastChangedAt == lastChangedAt &&
        other.changeInterval == changeInterval &&
        other.remainingKm == remainingKm;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        lastChangedAt.hashCode ^
        changeInterval.hashCode ^
        remainingKm.hashCode;
  }
}
