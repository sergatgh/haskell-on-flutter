import 'package:flutter/cupertino.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import '../../../pages.dart';
import '../build_func.dart';

class JournalsHandlerProcessor extends Processor {
  @override
  Future safeExecute(PipelineContext context) async {
    final routes = context.get<Map<String, BuildRoute>>("router", or: () => {});
    final journals = context.get<List<JournalViewModel>>("journals", or: () => <JournalViewModel>[]);

    for (var journal in journals) {
      routes.putIfAbsent("journal/${journal.identifier}", () => getJournalScreen);
    }
  }
  
  Widget getJournalScreen(BuildContext context) {
    return CategoryListPage();
  }

  @override
  bool safeCondition(PipelineContext context) {
    return context.getResult() == null && 
      context.get<String>("route", or: () => "").startsWith("journal/");
  }
}
