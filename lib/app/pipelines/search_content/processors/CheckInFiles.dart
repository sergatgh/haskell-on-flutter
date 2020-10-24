import 'dart:convert';
import 'dart:math';

import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/get_page_definition.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class CheckContentInFiles extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var link = context.get<Category>("link");
    var content = context.get<String>("search");

    context.setResult(await linkContainsContent(link, content));
  }

  Future<String> linkContainsContent(Category category, String content) async {
    var page = await GetCategoryContent.instance.getContent(category);
    var text = page.tabs
        .map((tab) => tab.getAll('raw-code'))
        .reduce((list1, list2) => list1.followedBy(list2))
        .firstWhere(
            (code) => code.toLowerCase().contains(content.toLowerCase()),
            orElse: () => null);
            
    if (text == null) return null;
    LineSplitter lineSplitter = LineSplitter();
    var lines = lineSplitter.convert(text);

    var index = lines.indexWhere(
        (element) => element.toLowerCase().contains(content.toLowerCase()));

    var minLine = 0;
    var maxLine = lines.length - 1;

    maxLine = min(maxLine, index + 2);
    minLine = max(minLine, index - 2);

    return lines.sublist(minLine, maxLine).join('\n');
  }
}
