import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import 'processors/get_content_of_json.dart';
import 'processors/get_content_of_sql.dart';
import 'processors/replace_remote_pieces.dart';

class GetCategoryContent extends AsyncPipeline {
  static final GetCategoryContent instance = GetCategoryContent();

  GetCategoryContent() : super([
    GetContentOfJson(), GetContentOfSql(), ReplaceRemotePieces()
  ]);

  Future<PageDefinition> getContent(Category category) async {
    final context = PipelineContext(props: { "resource": category });
    await this.runProcessors(context);
    return context.getResult<PageDefinition>();
  }
}
