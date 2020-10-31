import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/async_pipeline.dart';
import 'package:haskell_is_beautiful/base/context.dart';
import 'package:sqflite/sqflite.dart';

class SetLastUpdate extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var messages = await ExecuteDatabaseCommand.instance.executeCommand((Database db) async {
      await db.update('settings',
          {'title': 'last-update', 'value': DateTime.now().toIso8601String()});
    });
    context.messages.addAll(messages);
  }
}
