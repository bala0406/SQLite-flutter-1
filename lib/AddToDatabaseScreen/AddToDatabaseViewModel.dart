import 'package:assignment_1/Models/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class AddToDatabaseViewModel extends ChangeNotifier {


  Future addToDatabase(Database database, UserModel user) async {
    await database.insert("table1", user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort);
    notifyListeners();
  }

  
}
