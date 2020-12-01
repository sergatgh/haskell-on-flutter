import 'get_setting/get_setting.dart';
import 'set_setting/set_setting.dart';

class Settings {
  static Future<String> lastUpdate() async =>
      await SettingGetter.instance.get('last-update');
      
  static Future markLastUpdate() async =>
      await SettingSetter.instance.set('last-update', DateTime.now().toIso8601String());
}