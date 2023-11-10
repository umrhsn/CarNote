import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:hive/hive.dart';

part 'consumable.g.dart';

@HiveType(typeId: 2)
class Consumable extends HiveObject {
  @HiveField(0) int id;
  @HiveField(1) String name;
  @HiveField(2) final int lastChangedAt;
  @HiveField(3) final int changeInterval;
  @HiveField(4) final int remainingKm;

  Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.remainingKm,
  });

  static int getCount() => DatabaseHelper.consumableBox.get(AppKeys.consumableBox)!.length;
}
