import 'package:haskell_is_beautiful/app/pages/journals/task_list_view_model.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import 'processors.dart';

class GetJournalsPreviews extends AsyncPipeline {
  static final GetJournalsPreviews instance = GetJournalsPreviews();

  GetJournalsPreviews() : super([
    GetJournalsFromDatabase()
  ]);

  Future<List<JournalViewModel>> getContent() async {
    final context = PipelineContext(props: {  });
    await this.runProcessors(context);
    return context.getResult<List<JournalViewModel>>(or: <JournalViewModel> []);
  }
}
