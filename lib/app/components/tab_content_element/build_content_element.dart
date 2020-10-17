import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content_element/processors/add_code.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildContentElement extends Pipeline {
  BuildContentElement() : super([
      AddCode()
    ]);

  Widget buildElement(ContentPiece data) {
    return this.execute<Widget>({'data': data})[0];
  }
}
