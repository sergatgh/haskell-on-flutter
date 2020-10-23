import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/processors/get_topics_from_github.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/processors/put_content_in_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadCategories extends AsyncPipeline {

  static final DownloadCategories instance = DownloadCategories();

  DownloadCategories() : super([
    GetTopicsFromGithub(), PutContentInDatabase()
  ]);

  Future download() async {
    final context = PipelineContext();
    await this.runProcessors(context);
  }
}
