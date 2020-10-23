import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/processors/get_content_of_json.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/processors/get_content_of_sql.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetCategoryContent extends AsyncPipeline {
  GetCategoryContent() : super([
    GetContentOfJson(), GetContentOfSql()
  ]);

  Future<PageDefinition> getContent(Category resource, AssetBundle assetBundle) async {
    final context = PipelineContext();
    context.properties.addAll({ "resource": resource, "bundle": assetBundle });
    await this.runProcessors(context);
    return context.properties["result"] as PageDefinition;
  }
}
