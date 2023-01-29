import 'package:equatable/equatable.dart';

class Consumable extends Equatable {
  final String name;
  final int currentKilometers;
  final int changeInterval;
  final int changeKilometers;

  const Consumable({
    required this.name,
    required this.currentKilometers,
    required this.changeInterval,
    required this.changeKilometers,
  });

  @override
  List<Object?> get props => [
        name,
        currentKilometers,
        changeInterval,
        changeInterval,
      ];
}
