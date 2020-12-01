import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class SetSettingInDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var setting = context.get<String>("name");
    var value = context.get<String>("value");
    await ExecuteDatabaseCommand.instance.executeCommand((Database db) async {
      await db.update('settings',
          {'title': setting, 'value': value});
    }, context.onMessage);
  }
}
