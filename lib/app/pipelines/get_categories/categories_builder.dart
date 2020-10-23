import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/processors/get_topics_from_assets.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/processors/get_topics_from_database.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/processors/get_topics_from_github.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/processors/wrap_categories.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class CategoriesBuilder extends AsyncPipeline {
  CategoriesBuilder() : super([
    GetTopicsFromDatabase(), /*GetTopicsFromGithub(),*/ GetTopicsFromAssets(), WrapCategories(),
  ]);

  Future<ContentContainer> getTopics(AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as ContentContainer;
  }
}
