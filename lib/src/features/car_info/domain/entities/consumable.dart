import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:equatable/equatable.dart';

class Consumable extends Equatable {
  final int id;
  final String name;
  final int lastChangedAt;
  final int changeInterval;
  final int changeKm;

  const Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.changeKm,
  });

  static int getCount() => AppStrings.consumables.length;

  @override
  List<Object?> get props => [
        id,
        name,
        lastChangedAt,
        changeInterval,
        changeKm,
      ];
}
