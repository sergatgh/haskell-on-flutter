import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:recase/recase.dart';

class GetTopicsFromAssets extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var bundle = context.properties["bundle"] as AssetBundle;

    var categories = await this.getContent(bundle);
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = categories;
    } else {
      (context.properties["result"] as List<Category>).addAll(categories);
    }
  }

  Future<List<Category>> getContent(AssetBundle context) async {
    var files = await getMetadataFiles(context);
    var map = <Category>[];

    for (var file in files) {
      var jsonFiles = await getJsonFiles(file);

      for (var json in jsonFiles) {
        var key = getName(json);

        map.add(Category(json["tabs"], key, getIcon(json),
            topic: getCategory(json)));
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

  Future<List<Map<String, dynamic>>> getJsonFiles(String file) async {
    final content = await rootBundle.loadString(file);
    var json = jsonDecode(content);

    if (json is List) {
      return json.cast<Map<String, dynamic>>().toList();
    } else {
      return [json];
    }
  }

  Future<List<String>> getMetadataFiles(AssetBundle context) async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    // >> To get paths you need these 2 lines

    return Future.value(manifestMap.keys
        .where((String key) => key.contains('Topics/'))
        .where((String key) => key.endsWith('.json'))
        .toList());
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
