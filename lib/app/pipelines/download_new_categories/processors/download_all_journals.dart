import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/command_to_database/execute_database_command.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_journal/downloader.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:sqflite/sqflite.dart';

class DownloadAllJournals extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    List<Provider> providers;
    context.addMessage("Collecting journals to download.");
    await ExecuteDatabaseCommand.instance.executeCommand((Database db) async {
      var results = await db.query('provider');
      providers = results.map((e) => Provider.fromMap(e)).toList();
    }, context.onMessage);

    for (var provider in providers) {
      context.addMessage("Downloading \"${provider.title}\" journal.");
      await DownloadJournal.instance.download(provider, context.onMessage);
    }
  }
}
