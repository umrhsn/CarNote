import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String type;
  final int modelYear;
  final int currentKm;

  const Car({
    required this.type,
    required this.modelYear,
    required this.currentKm,
  });

  @override
  List<Object?> get props => [type, modelYear, currentKm];

  @override
  String toString() {
    return 'Car(type: $type, modelYear: $modelYear, currentKm: $currentKm)';
  }
}
