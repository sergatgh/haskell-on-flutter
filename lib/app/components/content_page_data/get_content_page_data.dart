import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/content_page_data/processors/get_content_of_files.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentPageData extends AsyncPipeline {
  GetContentPageData() : super([
    GetContentOfFiles()
  ]);

  Future<List<ContentData>> getContent(List<ContentResource> resources, AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "resources": resources, "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as List<ContentData>;
  }
}
