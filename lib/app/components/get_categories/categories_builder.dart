import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/get_categories/processors/get_topics_from_assets.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class CategoriesBuilder extends AsyncPipeline {
  CategoriesBuilder() : super([
    GetTopicsFromAssets()
  ]);

  Future<ContentContainer> getTopics(AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as ContentContainer;
  }
}
