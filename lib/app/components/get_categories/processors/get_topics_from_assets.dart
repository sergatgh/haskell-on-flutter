import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:recase/recase.dart';

class GetTopicsFromAssets extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var bundle = context.properties["bundle"] as AssetBundle;

    context.properties["result"] = await this.getContent(bundle);
  }

  Future<ContentContainer> getContent(AssetBundle context) async {
    var files = await getMetadataFiles(context);
    var map = ContentContainer(resources: []);

    for (var file in files) {
      var json = await getJson(file);
      var key = getName(json);

      map.resources.add(Category(json["tabs"], key, getIcon(json)));
    }

    return map;
  }

 String getIcon(Map<String, dynamic> json) {
   if (json.containsKey("icon")) {
     return json["icon"];
   }

   return "ac_unit";
 }

  Future<Map<String, dynamic>> getJson(String file) async {
    final content = await rootBundle.loadString(file);
    return jsonDecode(content);
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
