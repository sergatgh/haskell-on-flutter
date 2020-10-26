import 'package:haskell_is_beautiful/app/pipelines/get_setting/processors/get_setting_from_database.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class Settings extends AsyncPipeline {
  static Settings instance = Settings();
  Settings() : super([GetSettingFromDatabase()]);

  Future<String> get(String name) async {
    final context = PipelineContext(props: {'name': name});
    await runProcessors(context);
    return context.getResult<String>();
  }

  static Future<String> lastUpdate() async =>
      await Settings.instance.get('last-update');
}
