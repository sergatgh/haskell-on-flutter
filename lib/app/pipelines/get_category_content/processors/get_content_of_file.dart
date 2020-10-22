import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFile extends AsyncProcessor {

  @override
  Future safeExecute(PipelineContext context) async {
    var category = context.properties["resource"] as Category;

    var result = List<TabDefinition>();
    for (var tabJson in category.json) {
      var pieces = List<ContentPiece>();
      for (var piece in tabJson["content"]) {
        pieces.add(ContentPiece(piece["type"], piece["data"]));
      }
      var tab = TabDefinition(pieces, icon: tabJson["icon"]);
      result.add(tab);
    }
    context.properties["result"] = PageDefinition(category.title, result);
  }
}
