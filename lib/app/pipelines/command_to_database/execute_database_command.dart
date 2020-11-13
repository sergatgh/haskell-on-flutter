import 'processors.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

// Retrieves ContentContainer
class ExecuteDatabaseCommand extends AsyncPipeline {
  static final ExecuteDatabaseCommand instance = new ExecuteDatabaseCommand();

  ExecuteDatabaseCommand() : super([
    GetDatabase(), ExecuteCommand(), /*CloseDatabase()*/
  ]);

  Future executeCommand(Future Function(Database) func, List<void Function(ContextMessage)> onMessage) async {
    final context = PipelineContext(props: { "function": func }, onMessage: onMessage);
    await this.runProcessors(context);
  }
}
