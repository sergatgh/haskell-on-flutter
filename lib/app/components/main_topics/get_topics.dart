import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/main_topics/processors/get_content_from_json.dart';
import 'package:haskell_is_beautiful/app/components/main_topics/processors/get_topics_from_assets.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetTopics extends AsyncPipeline {
  GetTopics() : super([
    GetTopicsFromAssets()
  ]);

  Future<ContentContainer> getTopics(AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as ContentContainer;
  }
}
