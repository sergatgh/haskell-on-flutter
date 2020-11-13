import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/common/abort_if_no_internet.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/processors/download_metadata_files.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/processors/get_topics_from_github.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/processors/put_content_in_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadJournal extends AsyncPipeline {

  static final DownloadJournal instance = DownloadJournal();

  DownloadJournal() : super([
    AbortIfNoInternet(),
    DownloadMetadataFiles(),
    GetTopicsFromGithub(), 
    PutContentInDatabase()
  ]);

  Future<void> download(Provider provider, List<void Function(ContextMessage)> onMessage) async {
    final context = PipelineContext(props: {'provider': provider}, onMessage: onMessage);
    await this.runProcessors(context);
  }
}
