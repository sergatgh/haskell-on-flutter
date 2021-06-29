import 'package:flutter/cupertino.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import '../../../entities.dart';
import '../../../pages.dart';
import '../build_func.dart';

class PagesHandlerProcessor extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    final routes = context.get<Map<String, BuildRoute>>("router", or: () => {});
    final categories = context.get<List<Category>>("categories", or: () => <Category>[]);

    for (var category in categories) {
      routes.putIfAbsent("page/${category.title}", () => getPageScreen);
    }
  }
  
  Widget getPageScreen(BuildContext context) {
    return ContentPage();
  }
}
