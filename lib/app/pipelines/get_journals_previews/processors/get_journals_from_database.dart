import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class GetJournalsFromDatabase extends AsyncProcessor {

  @override
  Future safeExecute(PipelineContext context) async {
    List<JournalViewModel> result = [];
    await ExecuteDatabaseCommand.instance.executeCommand((Database db) async {
      final journals = await db.query("provider");
      result = journals.map((e) => JournalViewModel.fromMap(e)).toList();
    }, []);
    context.setResult(result);
  }
}
