import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

import 'processors.dart';

class BuildContentElement extends Pipeline {
  BuildContentElement() : super([
      AddCode(), AddCodeFromAsset(), AddRemoteCode(), AddMarkdown(),
    ]);

  Widget buildElement(ContentPiece data) {
    var result = this.execute<Widget>({'data': data });
    return result;
  }
}
