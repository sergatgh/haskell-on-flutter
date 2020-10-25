import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import "package:collection/collection.dart";

class GetContentOfSql extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var category = context.get<SqlCategory>("resource");
    var categoryContent = await getSqlContent(category.id);
    var tabGroups = groupBy(categoryContent, (obj) => obj["id"]);

    var result = List<TabDefinition>();
    for (var tabKey in tabGroups.keys) {
      var tab = tabGroups[tabKey][0];
      var pieces = List<ContentPiece>();
      for (var piece in tabGroups[tabKey]) {
        pieces.add(ContentPiece(piece["type"], piece["data"]));
      }
      var tabDefinition = TabDefinition(pieces, icon: tab["icon"]);
      result.add(tabDefinition);
    }
    context.properties["result"] = PageDefinition(category.title, result);
  }

  Future<List<Map<String, dynamic>>> getSqlContent(int categoryId) async {
    List<Map<String, dynamic>> result;
    await ExecuteDatabaseCommand.instance.executeCommand((db) async => result =
        await db.rawQuery(
            "SELECT tab.id, tab.icon, piece.type, piece.data FROM tab INNER JOIN piece ON piece.owner = tab.id WHERE tab.owner = ?;",
            [categoryId]));
    return result;
  }

  @override
  bool safeCondition(PipelineContext context) {
    return context.has<SqlCategory>("resource");
  }
}
