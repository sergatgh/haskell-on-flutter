import 'dart:io';

import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class GetContentFromLink extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var resource = context.properties["piece"] as dynamic;

    context.properties["result"] = ContentPiece(ContentType.linked_code, resource["url"]);
  }

  @override
  bool safeCondition(PipelineContext context) {
    var resource = context.properties["piece"] as dynamic;
    return resource["type"] == "remote-code";
  }
}
