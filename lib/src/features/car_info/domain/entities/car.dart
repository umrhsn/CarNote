import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 1)
class Car extends Equatable {
  @HiveField(0) final String type;
  @HiveField(1) final int modelYear;
  @HiveField(2) final int currentKm;

  const Car({
    required this.type,
    required this.modelYear,
    required this.currentKm,
  });

  @override
  List<Object?> get props => [type, modelYear, currentKm];
}
