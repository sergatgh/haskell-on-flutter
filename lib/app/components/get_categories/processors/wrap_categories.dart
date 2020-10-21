import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class WrapCategories extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var categories = context.properties["result"] as List<Category>;
    context.properties["result"] = ContentContainer(resources: categories);
  }
}
