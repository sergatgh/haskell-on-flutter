import 'package:haskell_is_beautiful/app/pipelines/get_category_content/processors/get_content_of_json.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/processors/get_content_of_sql.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/processors/replace_remote_code.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetCategoryContent extends AsyncPipeline {
  static final GetCategoryContent instance = GetCategoryContent();

  GetCategoryContent() : super([
    GetContentOfJson(), GetContentOfSql(), ReplaceRemoteCode()
  ]);

  Future<PageDefinition> getContent(Category resource) async {
    final context = PipelineContext();
    context.properties.addAll({ "resource": resource });
    await this.runProcessors(context);
    return context.properties["result"] as PageDefinition;
  }
}
