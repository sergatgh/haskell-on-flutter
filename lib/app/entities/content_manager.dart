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
    return Future.wait(files.map((e) => getContentData(context, e)));
  }
  
  Future<ContentPageData> getContentData(AssetBundle context, String file) async {
    var content = await context.loadString(file);
    var result = ContentPageData(contents: [
      ContentData(icon: Icon(Icons.accessibility_new), content: content),
    ], icon: Icon(Icons.ac_unit), title: file);

    return Future.value(result);
  }
}
