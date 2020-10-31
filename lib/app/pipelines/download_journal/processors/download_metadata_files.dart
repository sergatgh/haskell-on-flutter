import 'dart:convert';

import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_from_url/download_content.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class DownloadMetadataFiles extends TryProcessor {
  @override
  Future tryExecute(PipelineContext context) async {
    var provider = context.get<Provider>('provider');
    var links = await getMetadataFiles(provider.link);
    context.properties["links"] = links;
  }

  Future<List<String>> getMetadataFiles(String url) async {
    var content = await DownloadContent.instance.download(url);

    if (content == null || content.isEmpty || content.contains("Not Found")) {
      return [];
    }

    var json = jsonDecode(content);
    if (!(json is List)) {
      return [];
    }

    List<Map<String, dynamic>> jsonFiles =
        (json as List).cast<Map<String, dynamic>>();

    var collection = jsonFiles
        .where(isNotSettings)
        .map(getDownloadUrl)
        .where((element) => element != null);

    return collection.toList();
  }

  String getDownloadUrl(Map<String, dynamic> e) {
    return e.containsKey("download_url") ? e["download_url"] as String : null;
  }

  bool isNotSettings(Map<String, dynamic> e) {
    return e.containsKey("name") &&
        !e["name"].toString().startsWith("settings");
  }
}
