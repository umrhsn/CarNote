import 'package:equatable/equatable.dart';

class Car extends Equatable {
  final String type;
  final int modelYear;
  final int distanceTravelled;

  const Car({
    required this.type,
    required this.modelYear,
    required this.distanceTravelled,
  });

  @override
  List<Object?> get props => [
        type,
        modelYear,
        distanceTravelled,
      ];
}
