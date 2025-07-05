import 'package:equatable/equatable.dart';

class CarListItem extends Equatable {
  final String id;
  final String name;
  final String type;
  final int modelYear;
  final int currentKm;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isActive;

  const CarListItem({
    required this.id,
    required this.name,
    required this.type,
    required this.modelYear,
    required this.currentKm,
    required this.createdAt,
    required this.lastUpdated,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, type, modelYear, currentKm, createdAt, lastUpdated, isActive];

  CarListItem copyWith({
    String? id,
    String? name,
    String? type,
    int? modelYear,
    int? currentKm,
    DateTime? createdAt,
    DateTime? lastUpdated,
    bool? isActive,
  }) {
    return CarListItem(
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

  String get displayName => name.isNotEmpty ? name : '$type $modelYear';

  @override
  String toString() {
    return 'CarListItem(id: $id, name: $name, type: $type, modelYear: $modelYear, isActive: $isActive)';
  }
}
