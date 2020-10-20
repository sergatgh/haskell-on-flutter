import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:icons_helper/icons_helper.dart';
import 'package:recase/recase.dart';

class GetTopicsFromJson extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    // var bundle = context.properties["bundle"] as AssetBundle;
    // if (!context.properties.containsKey("result")) {
    //   context.properties["result"] = List<ContentLink>();
    // }

    // (context.properties["result"] as List<ContentLink>)
    //     .addAll(await this.getContents(bundle));
  }

  // Future<List<ContentLink>> getContents(AssetBundle context) async {
  //   var files = await getTopicFiles(context);
  //   var map = <String, ContentLink>{};

  //   for (var file in files) {
  //     var json = await getJson(file);
  //     var key = getName(json);

  //     var pageData = await getContentLink(file, json);
  //     map.putIfAbsent(key, () => pageData);
  //   }

  //   return Future.value(map.values.toList());
  // }

  // Future<ContentLink> getContentLink(
  //     String fileName, Map<String, dynamic> file) async {
  //   var result = ContentLink(
  //       resources: getFiles(file),
  //       icon: Icon(getIconUsingPrefix(name: getIcon(file))),
  //       title: getName(file),
  //       category: getCategory(file));

  //   return Future.value(result);
  // }

  // Future<Map<String, dynamic>> getJson(String file) async {
  //   final content = await rootBundle.loadString(file);
  //   return jsonDecode(content);
  // }

  // Future<List<String>> getTopicFiles(AssetBundle context) async {
  //   // >> To get paths you need these 2 lines
  //   final manifestContent = await rootBundle.loadString('AssetManifest.json');

  //   final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
  //   // >> To get paths you need these 2 lines

  //   return Future.value(manifestMap.keys
  //       .where((String key) => key.contains('Topics/'))
  //       .where((String key) => key.endsWith('.json'))
  //       .toList());
  // }

  // String getIcon(Map<String, dynamic> json) {
  //   if (json.containsKey("icon")) {
  //     return json["icon"];
  //   }

  //   return "ac_unit";
  // }

  // List<ContentResource> getFiles(Map<String, dynamic> json) {
  //   return (json["tabs"] as List).map((x) {
  //     var resource = x["resource"] as Map<String, dynamic>;
  //     if (resource.containsKey("file")) {
  //       return ContentResource(ResourceType.file, resource["file"] as String,
  //           icon: x["icon"] as String);
  //     }
  //     if (resource.containsKey("url")) {
  //       return ContentResource(ResourceType.link, resource["url"] as String,
  //           icon: x["icon"] as String);
  //     }
  //   }).toList();
  // }

  // String getName(Map<String, dynamic> json) {
  //   if (json.containsKey("title")) {
  //     String result = json["title"];

  //     ReCase rc = new ReCase(result);

  //     return rc.titleCase;
  //   }

  //   return "Interesting code";
  // }

  // String getCategory(Map<String, dynamic> json) {
  //   if (json.containsKey("category")) {
  //     return json["category"];
  //   }

  //   return "Other";
  // }
}
