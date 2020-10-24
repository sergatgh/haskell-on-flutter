import 'package:haskell_is_beautiful/app/pipelines/search_content/processors/CheckInFiles.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class ContentFinder extends AsyncPipeline {
  ContentFinder() : super([
    CheckContentInFiles()
  ]);

  Future<String> checkContent(Category link, String searchContent) async {
    final context = PipelineContext(props: { "link": link, "search": searchContent });
    await this.runProcessors(context);
    return context.getResult<String>();
  }
}
