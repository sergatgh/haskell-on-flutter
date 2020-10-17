import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFiles extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resources = context.properties["resources"] as List<ContentResource>;
    var bundle = context.properties["bundle"] as AssetBundle;

    var contents = List<ContentData>();
    for (var file in resources) {
      var content = await loadFromFile(bundle, file.link);
      contents.add(content);
    }
    context.properties["result"] = contents;
  }

  Future<ContentData> loadFromFile(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    return ContentData([ContentPiece(ContentType.code, content)]);
  }
}
