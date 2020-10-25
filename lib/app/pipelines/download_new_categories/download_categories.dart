import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/processors/download_all_journals.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadCategories extends AsyncPipeline {

  static final DownloadCategories instance = DownloadCategories();

  DownloadCategories() : super([
    DownloadAllJournals()
  ]);

  Future download() async {
    final context = PipelineContext();
    await this.runProcessors(context);
  }
}
