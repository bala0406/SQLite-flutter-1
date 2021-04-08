import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class FetchFromDatabaseViewModel extends ChangeNotifier {
  List<Map> results;
  void retriveFromDatabase(Database database, String name) async {
    results = await database.query("table1",
        columns: ["id", "name", "bio"], where: "name = ?", whereArgs: [name]);
    notifyListeners();
  }
}
