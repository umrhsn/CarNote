import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:car_note/injection_container.dart' as di;

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
  final int remainingKm;

  Consumable({
    required this.id,
    required this.name,
    required this.lastChangedAt,
    required this.changeInterval,
    required this.remainingKm,
  });

  static int getCount() =>
      di.sl<SharedPreferences>().getBool(AppStrings.prefsBoolListAdded) ?? false
          ? DatabaseHelper.consumableBox.length
          : AppStrings.consumables.length;
}
