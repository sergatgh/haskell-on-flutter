

import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class ExecuteCommand extends TryProcessor {
  @override
  Future tryExecute(PipelineContext context) async {
    var database = context.properties["db"] as Database;
    var command = context.properties["function"] as Future Function(Database);
    await command(database);
  }
}