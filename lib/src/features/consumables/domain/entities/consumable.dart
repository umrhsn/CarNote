import 'package:equatable/equatable.dart';

class Consumable extends Equatable {
  final int id;
  final String name;
  final int lastChangedAt;
  final int changeInterval;
  final int remainingKm;

  const Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.remainingKm,
  });

  @override
  List<Object?> get props =>
      [id, name, lastChangedAt, changeInterval, remainingKm];

  // Create a copy with updated values
  Consumable copyWith({
    int? id,
    String? name,
    int? lastChangedAt,
    int? changeInterval,
    int? remainingKm,
  }) {
    return Consumable(
      id: id ?? this.id,
      name: name ?? this.name,
      lastChangedAt: lastChangedAt ?? this.lastChangedAt,
      changeInterval: changeInterval ?? this.changeInterval,
      remainingKm: remainingKm ?? this.remainingKm,
    );
  }

  @override
  String toString() {
    return 'Consumable(id: $id, name: $name, lastChangedAt: $lastChangedAt, changeInterval: $changeInterval, remainingKm: $remainingKm)';
  }
}
