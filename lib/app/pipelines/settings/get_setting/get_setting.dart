import 'package:haskell_is_beautiful/app/pipelines/settings/get_setting/processors/get_setting_from_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class SettingGetter extends AsyncPipeline {
  static SettingGetter instance = SettingGetter();
  SettingGetter() : super([GetSettingFromDatabase()]);

  Future<String> get(String name) async {
    final context = PipelineContext(props: {'name': name});
    await runProcessors(context);
    return context.getResult<String>();
  }
}
