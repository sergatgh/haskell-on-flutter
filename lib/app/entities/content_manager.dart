import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities/content.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';
import 'package:path_provider/path_provider.dart';

class ContentManager {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
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

  Future<List<ContentPageData>> getContents(AssetBundle context) async {
    var files = await getCodeFiles(context);
    var map = <String, ContentPageData>{};

    for (var file in files) {
      var key = getName(file);
      var content = await getContent(context, file);
      ContentPageData pageData;
      if (map.containsKey(key)) {
        pageData = map[key];
      } else {
        pageData = await getContentData(file);
        map.putIfAbsent(key, () => pageData);
      }
      pageData.contents.add(content);
    }

    return Future.value(map.values.toList());
  }

  Future<ContentData> getContent(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    var result = ContentData(content: content);

    return Future.value(result);
  }

  Future<ContentPageData> getContentData(
      String file) async {
    var result = ContentPageData(
        contents: [],
        icon: Icon(Icons.ac_unit),
        title: getName(file),
        category: getCategory(file));

    return Future.value(result);
  }

  String getName(String name) {
    if (multiVariant(name)) {
      return Uri.decodeFull(name.split('/')[3]);
    }

    return name.split('/').last.replaceAll('.hs', '').replaceAll('-', ' ');
  }

  String getCategory(String name) {
    if (hasCategory(name)) {
      return name.split('/')[2];
    }

    return "Other";
  }

  bool multiVariant(String name) {
    var slashes = '/'.allMatches(name).length;
    return slashes >= 4;
  }

  bool hasCategory(String name) {
    var slashes = '/'.allMatches(name).length;
    return slashes >= 3;
  }
}
