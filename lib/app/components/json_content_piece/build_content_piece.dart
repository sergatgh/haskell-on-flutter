
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/json_content_piece/processors/get_code_from_asset.dart';
import 'package:haskell_is_beautiful/app/components/json_content_piece/processors/get_code_from_link.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildContentPieceFromJson extends AsyncPipeline {
  BuildContentPieceFromJson() : super([
    GetContentFromAsset(), GetContentFromLink()
  ]);

  Future<ContentPiece> getContent(dynamic pieceDescription, AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "piece": pieceDescription, "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as ContentPiece;
  }
}
