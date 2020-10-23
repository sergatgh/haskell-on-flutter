import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:recase/recase.dart';
import 'package:sqflite/sqflite.dart';

class GetTopicsFromDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var bundle = context.properties["bundle"] as AssetBundle;

    var categories = await this.getContent(bundle);
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = categories;
    } else {
      (context.properties["result"] as List<Category>).addAll(categories);
    }
  }

  Future<List<Category>> getContent(AssetBundle context) async {
    var jsonFiles = await getMetadataFiles(context);
    var map = <Category>[];

    for (var json in jsonFiles) {
      var key = getName(json);

      map.add(SqlCategory(json["id"], key, getIcon(json),
          topic: getCategory(json)));
    }

    return map;
  }

  String getIcon(Map<String, dynamic> json) {
    if (json.containsKey("icon")) {
      return json["icon"];
    }

    return "ac_unit";
  }

  Future<List<Map<String, dynamic>>> getMetadataFiles(
      AssetBundle context) async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/content.db';
    // Delete the database
    await deleteDatabase(path);
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

    return database.rawQuery("SELECT * FROM category");
  }

  String getName(Map<String, dynamic> json) {
    if (json.containsKey("title")) {
      String result = json["title"];
      ReCase rc = new ReCase(result);
      return rc.titleCase;
    }
    return "Interesting code";
  }

  String getCategory(Map<String, dynamic> json) {
    if (json.containsKey("category")) {
      return json["category"];
    }
    return "Other";
  }
}
