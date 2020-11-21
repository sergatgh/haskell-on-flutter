import 'package:haskell_is_beautiful/app/pipelines/settings/settings.dart';
import 'package:haskell_is_beautiful/base/async_pipeline.dart';
import 'package:haskell_is_beautiful/base/context.dart';

class SetLastUpdate extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) {
    return Settings.markLastUpdate();
  }
}
