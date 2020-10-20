import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfFile extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["resources"] as ContentResource;
    var bundle = context.properties["bundle"] as AssetBundle;

    var content = await loadFromFile(bundle, resource.link);
    context.properties["result"] = content;
  }

  @override
  bool safeCondition(PipelineContext context) {
    var resource = context.properties["resources"] as ContentResource;
    return resource.resourceType == ResourceType.file;
  }

  Future<ContentData> loadFromFile(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    return ContentData([ContentPiece(ContentType.code, content)]);
  }
}
