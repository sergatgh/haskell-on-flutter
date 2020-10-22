import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class CheckContentInFiles extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var bundle = context.properties["bundle"] as AssetBundle;
    var link = context.properties["link"] as Category;
    var content = context.properties["search"] as String;

    context.properties["result"] = await linkContainsContent(bundle, link, content);
  }

  Future<String> linkContainsContent(
      AssetBundle context, Category link, String content) async {
    // var list = await Future.wait(
    //     link.resources.where((element) => element.resourceType == ResourceType.file).map((file) => context.loadString(Uri.decodeFull(file.link))));

    // var text = list.firstWhere(
    //     (element) => element.toLowerCase().contains(content.toLowerCase()),
    //     orElse: () => null);
    // if (text == null) return null;
    // LineSplitter lineSplitter = LineSplitter();
    // var lines = lineSplitter.convert(text);

    // var index = lines.indexWhere(
    //     (element) => element.toLowerCase().contains(content.toLowerCase()));

    // var minLine = 0;
    // var maxLine = lines.length - 1;

    // maxLine = min(maxLine, index + 2);
    // minLine = max(minLine, index - 2);

    // return lines.sublist(minLine, maxLine).join('\n');
    return "IN DEVELOPMENT";
  }
}