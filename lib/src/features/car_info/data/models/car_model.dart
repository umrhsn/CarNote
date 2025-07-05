// lib/src/features/car_info/data/models/car_model.dart
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 1)
class CarModel extends HiveObject {
  @HiveField(0)
  final String type;

  @HiveField(1)
  final int modelYear;

  @HiveField(2)
  final int currentKm;

  CarModel({
    required this.type,
    required this.modelYear,
    required this.currentKm,
  });

  // Convert from domain entity to data model
  factory CarModel.fromEntity(Car car) {
    return CarModel(
      type: car.type,
      modelYear: car.modelYear,
      currentKm: car.currentKm,
    );
  }

  // Convert from data model to domain entity
  Car toEntity() {
    return Car(
      type: type,
      modelYear: modelYear,
      currentKm: currentKm,
    );
  }

  // For JSON serialization (if needed for API calls)
  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      type: json['type'] ?? '',
      modelYear: json['modelYear'] ?? 0,
      currentKm: json['currentKm'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'modelYear': modelYear,
      'currentKm': currentKm,
    };
  }

  @override
  String toString() {
    return 'CarModel(type: $type, modelYear: $modelYear, currentKm: $currentKm)';
  }
}
