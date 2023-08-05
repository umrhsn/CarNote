import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:hive/hive.dart';

part 'consumable.g.dart';

@HiveType(typeId: 2)
class Consumable extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final int lastChangedAt;

  @HiveField(3)
  final int changeInterval;

  @HiveField(4)
  final int remainingKm;

  static int count = 0;

  Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.remainingKm,
  }) {
    count++;
  }

  static int getCount() => DatabaseHelper.consumableBox.get(AppStrings.consumableBox)!.length;
}
