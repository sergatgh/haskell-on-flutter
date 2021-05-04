import 'dart:convert';
import 'dart:math';

import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages/categories/pipelines/get_category_content/get_page_definition.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class CheckContentInFiles extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var link = context.get<Category>("link");
    var content = context.get<String>("search");

    context.setResult(await linkContainsContent(link, content));
  }

  Future<List<ContentPiece>> linkContainsContent(
      Category category, String content) async {
    var page = await GetCategoryContent.instance.getContent(category);
    var pieces = <ContentPiece>[];

    for (var tab in page.tabs) {
      pieces.addAll(tab.getAllPieces('raw-code').where(
          (piece) => piece.data.toLowerCase().contains(content.toLowerCase())));
    }

    if (pieces.isEmpty) return pieces.toList();

    LineSplitter lineSplitter = LineSplitter();

    return pieces.map((e) {
      var lines = lineSplitter.convert(e.data);

      var index = lines.indexWhere(
          (element) => element.toLowerCase().contains(content.toLowerCase()));

      var minLine = 0;
      var maxLine = lines.length - 1;

      maxLine = min(maxLine, index + 2);
      minLine = max(minLine, index - 2);

      var resultLines = lines
          .sublist(minLine, maxLine)
          .where((line) => line.trim().isNotEmpty)
          .join('\n');
      return SearchContentPiece(e.type, resultLines);
    }).toList();
  }
}
