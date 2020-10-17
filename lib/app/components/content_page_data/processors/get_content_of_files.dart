import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFiles extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var files = context.properties["files"] as List<String>;
    var bundle = context.properties["bundle"] as AssetBundle;

    var contents = List<ContentData>();
    for (var file in files) {
      var content = await loadFromFile(bundle, file);
      contents.add(content);
    }
    context.properties["result"] = contents;
  }

  Future<ContentData> loadFromFile(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    return ContentData([ContentPiece(ContentType.code, content)]);
  }
}
