import 'dart:convert';
import 'dart:typed_data';
import 'package:car_note/src/core/database/database_helper.dart';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/core/utils/app_keys.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/intro/presentation/cubit/locale_cubit.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:car_note/injection_container.dart' as di;

class FileCreator {
  static bool enLocale = LocaleCubit.currentLangCode == AppStrings.en;

  static final DateTime _dateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
    DateTime.now().second,
  );

  static final String _dateTimeString = "${_dateTime.year}${_dateTime.month}${_dateTime.day}_${_dateTime.hour}${_dateTime.minute}${_dateTime.second}";

  static final String _fileName = "${enLocale ? 'CarNote' : 'مذكرةالسيارة'}_${enLocale ? _dateTimeString : _dateTimeString.toArabicNumerals()}";

  static String get fileName => _fileName;

  static String get _fileData {
    Car? car = DatabaseHelper.carBox.get(AppKeys.carBox);
    ConsumableCubit cubit = di.sl<ConsumableCubit>();

    String data =
        '${enLocale ? 'Current kilometer' : 'الكيلومتر الحالي'}: ${enLocale ? car!.currentKm.toThousands() : car!.currentKm.toThousands().toArabicNumerals()}\n';

    for (int index = 0; index < Consumable.getCount(); index++) {
      Consumable? item = DatabaseHelper.consumableBox.get(AppKeys.consumableBox)![index];
      if (item != null) {
        if (item.lastChangedAt != 0 || item.changeInterval != 0) {
          data += '\n${item.name}:${cubit.isErrorText(index) ? enLocale ? ' (Exceeded)' : ' (تم التجاوز)' : ''}'
              '\n${enLocale ? 'Last changed at' : 'تم التغيير عند'}: ${enLocale ? item.lastChangedAt.toThousands() : item.lastChangedAt.toThousands().toArabicNumerals()}'
              '\n${enLocale ? 'Change interval' : 'يتم التغيير كل'}: ${enLocale ? item.changeInterval.toThousands() : item.changeInterval.toThousands().toArabicNumerals()}'
              '\n${enLocale ? cubit.isErrorText(index) ? 'Exceeded by' : 'Remaining km' : cubit.isErrorText(index) ? 'تم التجاوز بمقدار' : 'الكيلومترات المتبقية'}: ${enLocale ? item.remainingKm < 0 ? (item.remainingKm * -1).toThousands() : item.remainingKm.toThousands() : item.remainingKm < 0 ? (item.remainingKm * -1).toThousands().toArabicNumerals() : item.remainingKm.toThousands().toArabicNumerals()}'
              '\n';
        }
      }
    }

    return data;
  }

  static Future<bool?> writeDataToFile() async {
    bool? saved;
    try {
      DocumentFileSavePlus().saveFile(Uint8List.fromList(utf8.encode(_fileData)), "$_fileName.txt", "text/plain");
      saved = true;
    } catch (e) {
      saved = false;
    }
    return saved;
  }
}
