import 'package:assignment_1/AddToDatabaseScreen/AddToDatabaseScreen.dart';
import 'package:assignment_1/FetchFromDatabaseScreen/FetchFromDatabaseScreen.dart';
import 'package:assignment_1/res/Styles.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class HomeScreen extends StatelessWidget {
  Database database;
  void openDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "user.db");
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE table1 (id INTEGER PRIMARY KEY autoincrement, name TEXT, bio TEXT)');
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      openDB();
    } catch (e) {
      print(e);
    }
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SQLite",
              style: TextStyle(color: Styles.primaryFontColor, fontSize: 72),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: MaterialButton(
                height: 56,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddToDatabaseScreen(database)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Add to Database",
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
                color: Styles.buttonColor,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: MaterialButton(
                height: 56,
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FetchFromDatabaseScreen(database)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Fetch from Database",
                  style: TextStyle(
                      color: Styles.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
                color: Styles.buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
