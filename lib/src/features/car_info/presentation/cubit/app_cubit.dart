import 'package:car_note/src/core/utils/extensions/string_helper.dart';
import 'package:car_note/src/features/car_info/domain/entities/consumable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial()) {
    for (int i = 0; i < Consumable.getCount(); i++) {
      lastChangedAtControllers.add(TextEditingController());
      changeIntervalControllers.add(TextEditingController());
      changeKmControllers.add(TextEditingController());
      lastChangedAtFocuses.add(FocusNode());
      changeIntervalFocuses.add(FocusNode());
      changeKmFocuses.add(FocusNode());
    }
    debugPrint('lastChangedAtControllers.length = ${lastChangedAtControllers.length}');
    debugPrint('changeIntervalControllers.length = ${changeIntervalControllers.length}');
    debugPrint('changeKmControllers.length = ${changeKmControllers.length}');
    debugPrint('lastChangedAtFocuses.length = ${lastChangedAtFocuses.length}');
    debugPrint('changeIntervalFocuses.length = ${changeIntervalFocuses.length}');
    debugPrint('changeKmFocuses.length = ${changeKmFocuses.length}');
  }

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  final TextEditingController currentKmController = TextEditingController();

  final List<TextEditingController> lastChangedAtControllers = [];
  final List<TextEditingController> changeIntervalControllers = [];
  final List<TextEditingController> changeKmControllers = [];

  final FocusNode currentKmFocus = FocusNode();

  final List<FocusNode> lastChangedAtFocuses = [];
  final List<FocusNode> changeIntervalFocuses = [];
  final List<FocusNode> changeKmFocuses = [];

  late Database db;

  // List<Consumable> consumables = [];
  // Map selectedConsumable = {};
  //
  // void initDb() async {
  //   String dbPath = await getDatabasesPath();
  //   String path = join(dbPath, AppStrings.db);
  //   _openDb(path: path);
  //   emit(DbInitialized());
  // }
  //
  // Future<Database> _openDb({required String path}) async {
  //   return await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
  //     // When creating the db, create the table
  //     await db.execute("CREATE TABLE ${AppStrings.dbTableName}"
  //         " (id INTEGER PRIMARY KEY,"
  //         " ${AppStrings.dbTableCol1} TEXT,"
  //         " ${AppStrings.dbTableCol2} INTEGER,"
  //         " ${AppStrings.dbTableCol3} INTEGER),"
  //         " ${AppStrings.dbTableCol4} INTEGER");
  //   }, onOpen: (Database db) {
  //     this.db = db;
  //     getAllConsumables();
  //   });
  // }
  //
  // void getAllConsumables() async {
  //   emit(DbLoading());
  //
  //   await db.rawQuery("SELECT * FROM ${AppStrings.dbTableName}").then(
  //         (value) {
  //       for (int i = 0; i < value.length; i++) {
  //         consumables.add(
  //           Consumable(
  //             id: i,
  //             name: AppStrings.consumables[i],
  //             lastChangedAt: lastChangedAtControllers[i].text.isNotEmpty
  //                 ? int.parse(lastChangedAtControllers[i].text.removeThousandSeparator())
  //                 : 0,
  //             changeInterval: changeIntervalControllers[i].text.isNotEmpty
  //                 ? int.parse(changeIntervalControllers[i].text.removeThousandSeparator())
  //                 : 0,
  //             changeKm: changeKmControllers[i].text.isNotEmpty
  //                 ? int.parse(changeKmControllers[i].text.removeThousandSeparator())
  //                 : 0,
  //           ),
  //         );
  //       }
  //       emit(DbLoaded());
  //     },
  //   );
  // }
  //
  // void insertConsumable({
  //   required String name,
  //   required int lastChangedAt,
  //   required int changeInterval,
  //   required int changeKm,
  // }) async {
  //   await db.transaction(
  //         (txn) async {
  //       await txn.rawInsert(
  //         "INSERT INTO ${AppStrings.dbTableName}"
  //             " ("
  //             "${AppStrings.dbTableCol1}"
  //             ", ${AppStrings.dbTableCol2}"
  //             ", ${AppStrings.dbTableCol3}"
  //             ", ${AppStrings.dbTableCol4}"
  //             ")"
  //             " VALUES ("
  //             "\"$name\""
  //             ", \"$lastChangedAt\""
  //             ", \"$changeInterval\""
  //             ", \"$changeKm\""
  //             ")",
  //       );
  //     },
  //   ).then((value) {
  //     debugPrint('Consumable Inserted');
  //     getAllConsumables();
  //     emit(DbConsumableCreated());
  //   });
  // }
  //
  // void selectConsumableToUpdate({required Map consumable}) {
  //   selectedConsumable = consumable;
  //   // FIXME
  //   AppStrings.consumables[0] = selectedConsumable[AppStrings.dbTableCol1];
  //   lastChangedAtControllers[0].text = selectedConsumable[AppStrings.dbTableCol2];
  //   changeIntervalControllers[0].text = selectedConsumable[AppStrings.dbTableCol3];
  //   changeKmControllers[0].text = selectedConsumable[AppStrings.dbTableCol4];
  // }
  //
  // void updateConsumableData() async {
  //   db.rawUpdate(
  //     "UPDATE ${AppStrings.dbTableName}"
  //         " SET ${AppStrings.dbTableCol1} = ?"
  //         ", ${AppStrings.dbTableCol2} = ?"
  //         ", ${AppStrings.dbTableCol3} = ?"
  //         ", ${AppStrings.dbTableCol4} = ?"
  //         " WHERE id = ${selectedConsumable['id']}",
  //     [
  //       // FIXME
  //       AppStrings.consumables[0],
  //       lastChangedAtControllers[0].text,
  //       changeIntervalControllers[0].text,
  //       changeKmControllers[0].text,
  //     ],
  //   ).then((value) {
  //     selectedConsumable = {};
  //     getAllConsumables();
  //   });
  // }

  bool shouldEnableSaveButton(BuildContext context) {
    for (int i = 0; i < lastChangedAtControllers.length; i++) {
      if (getLastChangedKmErrorText(context, i).data != '') {
        return false;
      }
    }
    return true;
  }

  Text getLastChangedKmErrorText(BuildContext context, int index) {
    return Text(
      validateLastChangedKilometer(index) ?? '',
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        height: validateLastChangedKilometer(index) != null ? 2 : 0,
        fontSize: 11,
      ),
    );
  }

  Text getChangeKmErrorText(BuildContext context, int index) {
    return Text(
      validateChangeKilometer(index) ?? '',
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        height: validateChangeKilometer(index) != null ? 2 : 0,
        fontSize: 11,
      ),
    );
  }

  int _sumChangeKilometer(TextEditingController lastChangedAtKmController,
      TextEditingController changeIntervalController) {
    if (lastChangedAtKmController.text.isNotEmpty && changeIntervalController.text.isNotEmpty) {
      return int.parse(lastChangedAtKmController.text.removeThousandSeparator()) +
          int.parse(changeIntervalController.text.removeThousandSeparator());
    }
    return 0;
  }

  void getChangeKilometer(int index) {
    emit(AddingChangeKm());
    changeKmControllers[index].text =
        _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index]) != 0
            ? _sumChangeKilometer(lastChangedAtControllers[index], changeIntervalControllers[index])
                .toThousands()
            : '';
    emit(AddedChangeKm());
  }

  void validateAllLastChangedKilometerFields() {
    emit(ValidatingItem());
    for (int i = 0; i < changeKmControllers.length; i++) {
      validateLastChangedKilometer(i);
    }
    emit(ValidatingComplete());
  }

  void validateAllChangeKilometerFields() {
    emit(ValidatingItem());
    for (int i = 0; i < changeKmControllers.length; i++) {
      validateChangeKilometer(i);
    }
    emit(ValidatingComplete());
  }

  getErrorText(int index) {
    return validateLastChangedKilometer(index);
  }

  // last changed kilometer should not exceed current kilometer
  String? validateLastChangedKilometer(int index) {
    emit(ValidatingItem());
    if (lastChangedAtControllers[index].text.isNotEmpty && currentKmController.text.isNotEmpty) {
      if (int.parse(lastChangedAtControllers[index].text.removeThousandSeparator()) >
          int.parse(currentKmController.text.removeThousandSeparator())) {
        return "invalid input";
      }
    }
    emit(ValidatingComplete());
    return null;
  }

  int calculateChangeKmAndCurrentKmDifference(int index) {
    if (currentKmController.text.isNotEmpty && changeKmControllers[index].text.isNotEmpty) {
      return int.parse(currentKmController.text.removeThousandSeparator()) -
          int.parse(changeKmControllers[index].text.removeThousandSeparator());
    }
    return 0;
  }

  // Gives a warning to the user if current kilometer exceeded change kilometer.
  // If exceeded; that means the user forgot to change the consumable item.
  String? validateChangeKilometer(int index) {
    emit(ValidatingItem());
    if (calculateChangeKmAndCurrentKmDifference(index) > 0) {
      int difference = calculateChangeKmAndCurrentKmDifference(index);
      return "Warning, exceeded by ${difference.toThousands()} km";
    }
    emit(ValidatingComplete());
    return null;
  }
}
