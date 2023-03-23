import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:hive/hive.dart';

part 'consumable.g.dart';

@HiveType(typeId: 2)
class Consumable extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int lastChangedAt;

  @HiveField(3)
  final int changeInterval;

  @HiveField(4)
  final int changeKm;

  static int count = 0;

  Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.changeKm,
  }) {
    count++;
  }

  static int getCount() => count;
}
