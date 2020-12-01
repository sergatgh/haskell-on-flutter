import 'package:haskell_is_beautiful/app/pipelines/settings/set_setting/processors/set_setting_in_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class SettingSetter extends AsyncPipeline {
  static SettingSetter instance = SettingSetter();
  SettingSetter() : super([SetSettingInDatabase()]);

  Future set(String name, Object value) async {
    final context = PipelineContext(props: {'name': name, 'value': value});
    await runProcessors(context);
  }
}
