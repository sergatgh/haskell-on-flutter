import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import 'processors/get_topics_from_assets.dart';
import 'processors/get_topics_from_database.dart';
import 'processors/wrap_categories.dart';

// Retrieves ContentContainer
class CategoriesBuilder extends AsyncPipeline {
  CategoriesBuilder() : super([
    GetTopicsFromDatabase(), GetTopicsFromAssets(), WrapCategories(),
  ]);

  Future<ContentContainer> getTopics(AssetBundle assetBundle) async {
    final context = PipelineContext(props: { "bundle": assetBundle });
    await this.runProcessors(context);
    return context.getResult<ContentContainer>();
  }
}
