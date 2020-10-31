import 'dart:convert';
import 'dart:io';

import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:recase/recase.dart';

class GetTopicsFromGithub extends TryProcessor {
  @override
  Future tryExecute(PipelineContext context) async {
    var categories = await this.getContent(context.get<List<String>>('links'));
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = categories;
    } else {
      (context.properties["result"] as List<Category>).addAll(categories);
    }
  }

  Future<List<Category>> getContent(List<String> links) async {
    var map = <Category>[];

    for (var link in links) {
      var jsonFiles = await getJsonFiles(link);

      for (var json in jsonFiles) {
        var key = getName(json);

        map.add(
            JsonCategory(json["tabs"], key, getIcon(json), topic: getCategory(json))); 
      }
    }

    return map;
  }

  String getIcon(Map<String, dynamic> json) {
    if (json.containsKey("icon")) {
      return json["icon"];
    }

    return "ac_unit";
  }

  Future<List<Map<String, dynamic>>> getJsonFiles(String url) async {
    var content = "";
    var uri = Uri.parse(url);

    await new HttpClient()
        .getUrl(uri)
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) async =>
            await response.transform(new Utf8Decoder()).listen((data) {
              content += data;
            }).asFuture());
    var json = jsonDecode(content);

    if (json is List) {
      return json.cast<Map<String, dynamic>>().toList();
    } else {
      return [json];
    }
  }

  String getName(Map<String, dynamic> json) {
    if (json.containsKey("title")) {
      String result = json["title"];
      ReCase rc = new ReCase(result);
      return rc.titleCase;
    }
    return "Interesting code";
  }

  String getCategory(Map<String, dynamic> json) {
    if (json.containsKey("category")) {
      return json["category"];
    }
    return "Other";
  }
}
