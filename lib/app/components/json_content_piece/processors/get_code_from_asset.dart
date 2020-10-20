import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentFromAsset extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["piece"] as dynamic;
    var bundle = context.properties["bundle"] as AssetBundle;

    var content = await loadFromFile(bundle, resource["file"]);
    context.properties["result"] = content;
  }

  @override
  bool safeCondition(PipelineContext context) {
    var resource = context.properties["piece"] as dynamic;
    return resource["type"] == "asset-code";
  }

  Future<ContentPiece> loadFromFile(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    return ContentPiece(ContentType.code, content);
  }
}
