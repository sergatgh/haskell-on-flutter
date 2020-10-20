import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentFromLink extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["piece"] as dynamic;
    var bundle = context.properties["bundle"] as AssetBundle;

    var content = await loadFromUrl(bundle, resource["url"]);
    context.properties["result"] = content;
  }

  @override
  bool safeCondition(PipelineContext context) {
    var resource = context.properties["piece"] as dynamic;
    return resource["type"] == "remote-code";
  }

  Future<ContentPiece> loadFromUrl(AssetBundle context, String url) async {
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
    return ContentPiece(ContentType.code, content);
  }
}
