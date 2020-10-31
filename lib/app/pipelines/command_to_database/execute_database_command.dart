import 'processors.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

// Retrieves ContentContainer
class ExecuteDatabaseCommand extends AsyncPipeline {
  static final ExecuteDatabaseCommand instance = new ExecuteDatabaseCommand();

  ExecuteDatabaseCommand() : super([
    GetDatabase(), ExecuteCommand(), /*CloseDatabase()*/
  ]);

  Future<List<String>> executeCommand(Future Function(Database) func) async {
    final context = PipelineContext(props: { "function": func });
    await this.runProcessors(context);
    return context.messages;
  }
}
