import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/search_content/processors/CheckInFiles.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class ContentFinder extends AsyncPipeline {
  ContentFinder() : super([
    CheckContentInFiles()
  ]);

  Future<String> checkContent(AssetBundle assetBundle, ContentResource link, String searchContent) async {
    final context = PipelineContext();
    context.properties.addAll({ "bundle": assetBundle, "link": link, "search": searchContent });
    await this.runProcessors(context);
    return context.properties["result"] as String;
  }
}
