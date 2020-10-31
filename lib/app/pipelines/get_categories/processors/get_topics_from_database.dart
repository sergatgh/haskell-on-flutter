import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetTopicsFromDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var categories = await this.getContent(context);
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = categories;
    } else {
      (context.properties["result"] as List<Category>).addAll(categories);
    }
  }

  Future<List<Category>> getContent(PipelineContext context) async {
    var jsonFiles;
    var messages = await ExecuteDatabaseCommand.instance.executeCommand(
        (db) async => jsonFiles = await db.rawQuery("SELECT * FROM category"));
    context.messages.addAll(messages);
    var map = <Category>[];

    for (var json in jsonFiles) {
      map.add(SqlCategory.fromMap(json));
    }

    return map;
  }

}
