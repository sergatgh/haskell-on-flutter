import 'package:haskell_is_beautiful/app/pipelines/common/abort_if_no_internet.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/processors/download_all_journals.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/processors/set_last_update.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadCategories extends AsyncPipeline {

  static final DownloadCategories instance = DownloadCategories();

  DownloadCategories() : super([
    AbortIfNoInternet(), DownloadAllJournals(), SetLastUpdate()
  ]);

  Future download(List<void Function(ContextMessage)> onMessage) async {
    final context = PipelineContext(onMessage: onMessage);
    await this.runProcessors(context);
  }
}
