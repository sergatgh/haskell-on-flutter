import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/processors/get_topics_from_github.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/processors/put_content_in_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadJournal extends AsyncPipeline {

  static final DownloadJournal instance = DownloadJournal();

  DownloadJournal() : super([
    GetTopicsFromGithub(), PutContentInDatabase()
  ]);

  Future download(Provider provider) async {
    final context = PipelineContext(props: {'provider': provider});
    await this.runProcessors(context);
  }
}
