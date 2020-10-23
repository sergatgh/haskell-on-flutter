import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/get_page_definition.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class PutContentInDatabase extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var categories = (context.properties["result"] as List<Category>);

    for (var category in categories) {
      var pageDefinition =
          await GetCategoryContent.instance.getContent(category);
      await addToDatabase(category, pageDefinition);
    }
  }

  @override
  bool safeCondition(PipelineContext context) {
    return context.properties.containsKey("result");
  }

  Future addToDatabase(Category category, PageDefinition pageDefinition) async {
    var script = (Database db) async {
      var count = Sqflite.firstIntValue(await db.rawQuery(
          'SELECT COUNT(*) from category where category.category = ? AND category.title = ?',
          [category.topic, category.title]));

      if (count == 0) {
        await db.transaction((txn) async {
          var categoryId = await txn.insert('category', {
            'category': category.topic,
            'title': category.title,
            'icon': category.icon,
            'owner': 1,
          });
          for (var tab in pageDefinition.tabs) {
            var tabId = await txn
                .insert('tab', {'owner': categoryId, 'icon': tab.icon});
            for (var piece in tab.pieces) {
              await txn.insert('piece',
                  {'owner': tabId, 'type': piece.type, 'data': piece.data});
            }
          }
        });
      }
    };

    await ExecuteDatabaseCommand.instance.executeCommand(script);
  }
}
