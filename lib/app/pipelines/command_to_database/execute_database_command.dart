import 'package:haskell_is_beautiful/app/pipelines/command_to_database/processors/close_database.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/processors/execute_command.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/processors/get_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

// Retrieves ContentContainer
class ExecuteDatabaseCommand extends AsyncPipeline {
  static final ExecuteDatabaseCommand instance = new ExecuteDatabaseCommand();

  ExecuteDatabaseCommand() : super([
    GetDatabase(), ExecuteCommand(), CloseDatabase()
  ]);

  Future executeCommand(Future Function(Database) func) async {
    final context = PipelineContext();
    context.properties.addAll({ "function": func });
    await this.runProcessors(context);
  }
}
