import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/content_page_data/processors/get_content_of_file.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentPageData extends AsyncPipeline {
  GetContentPageData() : super([
    GetContentOfFile()
  ]);

  Future<PageDefinition> getContent(Category resource, AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "resource": resource, "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as PageDefinition;
  }
}
