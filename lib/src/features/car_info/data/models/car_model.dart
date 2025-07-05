import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'car_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class CarModel extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'type')
  final String type;
  
  @HiveField(1)
  @JsonKey(name: 'modelYear')
  final int modelYear;
  
  @HiveField(2)
  @JsonKey(name: 'currentKm')
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

  // JSON serialization
  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);

  @override
  String toString() {
    return 'CarModel(type: $type, modelYear: $modelYear, currentKm: $currentKm)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CarModel &&
        other.type == type &&
        other.modelYear == modelYear &&
        other.currentKm == currentKm;
  }

  @override
  int get hashCode => type.hashCode ^ modelYear.hashCode ^ currentKm.hashCode;
}
