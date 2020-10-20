import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentOfLink extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["resources"] as ContentResource;
    var bundle = context.properties["bundle"] as AssetBundle;

    var content = await loadFromUrl(bundle, resource.link);
    context.properties["result"] = content;
  }

  @override
  bool safeCondition(PipelineContext context) {
    var resource = context.properties["resources"] as ContentResource;
    return resource.resourceType == ResourceType.link;
  }

  Future<ContentData> loadFromUrl(AssetBundle context, String url) async {
    var content = "";
    await Future.wait([
      new HttpClient()
          .getUrl(Uri.parse(url))
          .then((HttpClientRequest request) => request.close())
          .then((HttpClientResponse response) =>
              response.transform(new Utf8Decoder()).listen((data) {
                content = data;
              }).asFuture())
    ]);
    return ContentData([ContentPiece(ContentType.code, content)]);
  }
}
