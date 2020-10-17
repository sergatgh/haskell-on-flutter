import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:recase/recase.dart';

class GetTopicsFromAssets extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var bundle = context.properties["bundle"] as AssetBundle;

    if (!context.properties.containsKey("result")) {
      context.properties["result"] = List<ContentLink>();
    }

    (context.properties["result"] as List<ContentLink>)
        .addAll(await this.getContents(bundle));
  }

  Future<List<ContentLink>> getContents(AssetBundle context) async {
    var files = await getCodeFiles(context);
    var map = <String, ContentLink>{};

    for (var file in files) {
      var key = getName(file);

      if (map.containsKey(key)) {
        var pageData = map[key];
        pageData.resources.add(ContentResource(ResourceType.file,file));
      } else {
        var pageData = await getContentLink(file);
        map.putIfAbsent(key, () => pageData);
      }
    }

    return Future.value(map.values.toList());
  }

  Future<ContentLink> getContentLink(String file) async {
    var result = ContentLink(
        resources: [ContentResource(ResourceType.file, file)],
        icon: Icon(Icons.ac_unit),
        title: getName(file),
        category: getCategory(file));

    return Future.value(result);
  }

  Future<List<String>> getCodeFiles(AssetBundle context) async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    // >> To get paths you need these 2 lines

    return Future.value(manifestMap.keys
        .where((String key) => key.contains('Code/'))
        .where((String key) => key.endsWith('.hs'))
        .toList());
  }

  String getName(String path) {
    String result;

    if (isMultiVariant(path)) {
      result = Uri.decodeFull(path.split('/')[3]);
    } else {
      result = path.split('/').last.replaceAll('.hs', '');
    }

    ReCase rc = new ReCase(result);

    return rc.titleCase;
  }

  String getCategory(String path) {
    if (hasCategory(path)) {
      return path.split('/')[2];
    }

    return "Other";
  }

  bool isMultiVariant(String path) {
    var slashes = '/'.allMatches(path).length;
    return slashes >= 4;
  }

  bool hasCategory(String path) {
    var slashes = '/'.allMatches(path).length;
    return slashes >= 3;
  }
}
