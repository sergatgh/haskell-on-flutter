

import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class CloseDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var database = context.properties["db"] as Database;
    await database.close();
  }
}