import 'package:haskell_is_beautiful/app/pipelines/common/abort_if_no_internet.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_from_url/processors/download.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

// Retrieves ContentContainer
class DownloadContent extends AsyncPipeline {

  static final DownloadContent instance = DownloadContent();

  DownloadContent() : super([
    AbortIfNoInternet(), JustDownload()
  ]);

  Future<String> download(String url) async {
    final context = PipelineContext(props: { "url": url });
    await this.runProcessors(context);
    return context.getResult<String>(or: '');
  }
}
