import 'dart:convert';
import 'dart:typed_data';
import 'package:car_note/src/core/extensions/string_helper.dart';
import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:car_note/src/features/car_info/domain/entities/car.dart';
import 'package:car_note/src/features/car_info/presentation/cubit/car_cubit.dart';
import 'package:car_note/src/features/consumables/domain/entities/consumable.dart';
import 'package:car_note/src/features/consumables/presentation/cubit/consumable_cubit.dart';
import 'package:car_note/src/features/splash/presentation/cubit/locale_cubit.dart';
import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:car_note/injection_container.dart' as di;

class FileCreator {
  static String _createDataForFile() {
    bool enLocale = LocaleCubit.currentLangCode == AppStrings.en;
    Car? car = CarCubit.carBox.get(AppStrings.carBox);

    String data =
        '${enLocale ? 'Current kilometer' : 'الكيلومتر الحالي'}: ${enLocale ? car!.currentKm.toThousands() : car!.currentKm.toThousands().toArabicNumerals()}\n';

    ConsumableCubit cubit = di.sl<ConsumableCubit>();
    for (int index = 0; index < Consumable.getCount(); index++) {
      Consumable? item = ConsumableCubit.consumableBox.get(index);
      if (item != null) {
        if (item.lastChangedAt != 0 || item.changeInterval != 0) {
          data +=
              '\n${enLocale ? AppStrings.consumablesEnglishList[index] : AppStrings.consumablesArabicList[index]}:${cubit.isErrorText(index) ? enLocale ? ' (Exceeded)' : ' (تم التجاوز)' : ''}'
              '\n${enLocale ? 'Last changed at' : 'تم التغيير عند'}: ${enLocale ? item.lastChangedAt.toThousands() : item.lastChangedAt.toThousands().toArabicNumerals()}'
              '\n${enLocale ? 'Change interval' : 'يتم التغيير كل'}: ${enLocale ? item.changeInterval.toThousands() : item.changeInterval.toThousands().toArabicNumerals()}'
              '\n${enLocale ? cubit.isErrorText(index) ? 'Exceeded by' : 'Remaining km' : cubit.isErrorText(index) ? 'تم التجاوز بمقدار' : 'الكيلومترات المتبقية'}: ${enLocale ? item.remainingKm < 0 ? (item.remainingKm * -1).toThousands() : item.remainingKm.toThousands() : item.remainingKm < 0 ? (item.remainingKm * -1).toThousands().toArabicNumerals() : item.remainingKm.toThousands().toArabicNumerals()}'
              '\n';
        }
      }
    }

    return data;
  }

  static Future<void> writeDataToFile() {
    String data = _createDataForFile();

    return DocumentFileSavePlus()
        .saveFile(Uint8List.fromList(utf8.encode(data)), "car_note.txt", "text/plain");
  }
}
