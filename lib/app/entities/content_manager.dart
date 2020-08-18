import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:recase/recase.dart';

class ContentManager {
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

  Future<List<ContentLink>> getContents(AssetBundle context) async {
    var files = await getCodeFiles(context);
    var map = <String, ContentLink>{};

    for (var file in files) {
      var key = getName(file);

      if (map.containsKey(key)) {
        var pageData = map[key];
        pageData.files.add(file);
      } else {
        var pageData = await getContentLink(file);
        map.putIfAbsent(key, () => pageData);
      }
    }

    return Future.value(map.values.toList());
  }

  Future<ContentData> getContent(AssetBundle context, String file) async {
    var content = await context.loadString(Uri.decodeFull(file));
    var result = ContentData(content: content);

    return Future.value(result);
  }

  Future<ContentLink> getContentLink(String file) async {
    var result = ContentLink(
        files: [file],
        icon: Icon(Icons.ac_unit),
        title: getName(file),
        category: getCategory(file));

    return Future.value(result);
  }

  Future<String> linkContainsContent(
      AssetBundle context, ContentLink link, String content) async {
    var list = await Future.wait(
        link.files.map((file) => context.loadString(Uri.decodeFull(file))));

    var text = list.firstWhere(
        (element) => element.toLowerCase().contains(content.toLowerCase()),
        orElse: () => null);
    if (text == null) return null;
    LineSplitter lineSplitter = LineSplitter();
    var lines = lineSplitter.convert(text);

    var index = lines.indexWhere(
        (element) => element.toLowerCase().contains(content.toLowerCase()));

    var minLine = 0;
    var maxLine = lines.length - 1;

    maxLine = min(maxLine, index + 2);
    minLine = max(minLine, index - 2);

    return lines.sublist(minLine, maxLine).join('\n');
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
