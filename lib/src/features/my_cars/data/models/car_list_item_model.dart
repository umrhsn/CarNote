import 'package:car_note/src/features/my_cars/domain/entities/car_list_item.dart';
import 'package:hive/hive.dart';

part 'car_list_item_model.g.dart';

@HiveType(typeId: 4)
class CarListItemModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String type;
  
  @HiveField(3)
  final int modelYear;
  
  @HiveField(4)
  final int currentKm;
  
  @HiveField(5)
  final DateTime createdAt;
  
  @HiveField(6)
  final DateTime lastUpdated;
  
  @HiveField(7)
  final bool isActive;

  CarListItemModel({
    required this.id,
    required this.name,
    required this.type,
    required this.modelYear,
    required this.currentKm,
    required this.createdAt,
    required this.lastUpdated,
    required this.isActive,
  });

  // Convert from domain entity to data model
  factory CarListItemModel.fromEntity(CarListItem carListItem) {
    return CarListItemModel(
      id: carListItem.id,
      name: carListItem.name,
      type: carListItem.type,
      modelYear: carListItem.modelYear,
      currentKm: carListItem.currentKm,
      createdAt: carListItem.createdAt,
      lastUpdated: carListItem.lastUpdated,
      isActive: carListItem.isActive,
    );
  }

  // Convert from data model to domain entity
  CarListItem toEntity() {
    return CarListItem(
      id: id,
      name: name,
      type: type,
      modelYear: modelYear,
      currentKm: currentKm,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      isActive: isActive,
    );
  }

  // For JSON serialization
  factory CarListItemModel.fromJson(Map<String, dynamic> json) {
    return CarListItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      modelYear: json['modelYear'] ?? 0,
      currentKm: json['currentKm'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      lastUpdated: DateTime.parse(json['lastUpdated'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'modelYear': modelYear,
      'currentKm': currentKm,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'isActive': isActive,
    };
  }

  CarListItemModel copyWith({
    String? id,
    String? name,
    String? type,
    int? modelYear,
    int? currentKm,
    DateTime? createdAt,
    DateTime? lastUpdated,
    bool? isActive,
  }) {
    return CarListItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      modelYear: modelYear ?? this.modelYear,
      currentKm: currentKm ?? this.currentKm,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'CarListItemModel(id: $id, name: $name, type: $type, modelYear: $modelYear, isActive: $isActive)';
  }
}
