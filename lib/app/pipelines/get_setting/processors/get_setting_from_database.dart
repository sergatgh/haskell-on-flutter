import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class GetSettingFromDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var setting = context.get<String>("name");
    String value;
    await ExecuteDatabaseCommand.instance.executeCommand((Database db) async {
      var result = await db.query('settings',
          columns: ['value'], where: 'title = ?', whereArgs: [setting]);

      if (result.isNotEmpty && result.first.containsKey('value')) {
        value = result.first['value'];
      }
    });

    context.properties["result"] = value;
  }
}
