import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class GetDatabase extends TryProcessor {
  @override
  Future tryExecute(PipelineContext context) async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + '/content.db';
    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      if (version == 1) {
        // Insert some records in a transaction
        await db.transaction((txn) async {
          for (var query in scripts) {
            await txn.execute(query);
          }
        });
      }
    });

    context.properties["db"] = database;
  }

  static List<String> scripts = [
    "PRAGMA foreign_keys = ON;",
    """CREATE TABLE provider (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      title VARCHAR(128) NOT NULL, 
      link VARCHAR(1024) NOT NULL, 
      icon VARCHAR(32));
    """,
    """
    CREATE TABLE category (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      category VARCHAR(128) NOT NULL, 
      title VARCHAR(256) NOT NULL,
      icon VARCHAR(32), 
      created TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
      updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
      viewed TIMESTAMP DEFAULT NULL,
      owner int, 
      FOREIGN KEY(owner) REFERENCES provider(id) ON DELETE CASCADE);
    """,
    """
    CREATE TABLE tab (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      icon VARCHAR(64), 
      owner int, 
      FOREIGN KEY(owner) REFERENCES category(id) ON DELETE CASCADE);
    """,
    """
    CREATE TABLE piece (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      type VARCHAR(16), 
      data TEXT, 
      owner int, 
      FOREIGN KEY(owner) REFERENCES tab(id) ON DELETE CASCADE);
    """,
    """
    CREATE TABLE settings (
      title VARCHAR(64) PRIMARY KEY,
      value TEXT
    )
    """,
    """
    INSERT INTO provider VALUES (
      1, 'Witty Lion', 'https://api.github.com/repositories/307157040/contents/Topics', 'wolfPackBattalion');
    """,
    """
    INSERT INTO settings VALUES (
      'last-update', NULL
    );
    """
  ];
}
