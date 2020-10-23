

import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class GetDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/content.db';
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      if (version == 1) {
        // Insert some records in a transaction
        await db.transaction((txn) async {
          await txn.execute("PRAGMA foreign_keys = ON;");
          await txn.execute(
              "CREATE TABLE category (id INTEGER PRIMARY KEY AUTOINCREMENT, category VARCHAR(128) NOT NULL, title VARCHAR(256) NOT NULL,icon VARCHAR(32));");
          await txn.execute(
              "CREATE TABLE tab (id INTEGER PRIMARY KEY AUTOINCREMENT, icon VARCHAR(64), owner int, FOREIGN KEY(owner) REFERENCES category(id) ON DELETE CASCADE);");
          await txn.execute(
              "CREATE TABLE piece (id INTEGER PRIMARY KEY AUTOINCREMENT, type VARCHAR(16), data TEXT, owner int, FOREIGN KEY(owner) REFERENCES tab(id) ON DELETE CASCADE);");

          await txn.rawInsert(
              "INSERT INTO category VALUES (1, 'Algorythms', 'Merge Sort', 'sortAlphaDown');");
          await txn.rawInsert(
              "INSERT INTO tab VALUES (1, 'sort-amount-down', 1);");
          await txn.rawInsert(
              "INSERT INTO piece VALUES (1, 'remote-code', 'https://raw.githubusercontent.com/SergAtGitHub/Haskell-on-Flutter/master/assets/Code/Algorythms/Merge%20Sort/merge-sort.hs', 1);");
          await txn.rawInsert(
              "INSERT INTO tab VALUES (2, '', 1);");
          await txn.rawInsert(
              "INSERT INTO piece VALUES (2, 'remote-code', 'https://raw.githubusercontent.com/SergAtGitHub/Haskell-on-Flutter/master/assets/Code/Algorythms/Merge%20Sort/merge-sort2.hs', 2);");
        });
      }
    });

    context.properties["db"] = database;
  }
}