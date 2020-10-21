import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/json_content_piece/build_content_piece.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFile extends AsyncProcessor {
  BuildContentPieceFromJson pieceBuilder = BuildContentPieceFromJson();

  @override
  Future safeExecute(PipelineContext context) async {
    var category = context.properties["resource"] as Category;
    var bundle = context.properties["bundle"] as AssetBundle;

    var result = List<TabDefinition>();
    for (var tabJson in category.data) {
      var pieces = List<ContentPiece>();
      for (var piece in tabJson["content"]) {
        pieces.add(await pieceBuilder.getContent(piece, bundle));
      }
      var tab = TabDefinition(pieces,icon: tabJson["icon"]);
      result.add(tab);
    }
    context.properties["result"] = PageDefinition(category.title, result);
  }
}
