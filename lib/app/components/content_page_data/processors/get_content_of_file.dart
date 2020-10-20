import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/json_content_piece/build_content_piece.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFile extends AsyncProcessor {
  BuildContentPieceFromJson pieceBuilder = BuildContentPieceFromJson();

  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["resource"] as ContentResource;
    var bundle = context.properties["bundle"] as AssetBundle;

    var result = List<ContentData>();
    for (var tabJson in resource.data) {
      var pieces = List<ContentPiece>();
      for (var piece in tabJson["content"]) {
        pieces.add(await pieceBuilder.getContent(piece, bundle));
      }
      var tab = ContentData(pieces,icon: tabJson["icon"]);
      result.add(tab);
    }
    context.properties["result"] = result;
  }
}
