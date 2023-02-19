import 'dart:io';

import 'package:car_note/src/core/utils/app_strings.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future<Database> createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, AppStrings.databaseName);
    var database = await openDatabase(path, version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  // This is optional, only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE ${AppStrings.consumablesTable} ("
      "id INTEGER PRIMARY KEY, "
      "${AppStrings.consumablesTableCol1} TEXT, "
      "${AppStrings.consumablesTableCol2} INTEGER, "
      "${AppStrings.consumablesTableCol3} INTEGER, "
      "${AppStrings.consumablesTableCol4} INTEGER"
      ")",
    );
  }
}
