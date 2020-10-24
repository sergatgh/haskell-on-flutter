import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/processors/add_code.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/processors/add_code_from_asset.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_element_widget/processors/add_remote_code.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildContentElement extends Pipeline {
  BuildContentElement() : super([
      AddCode(), AddCodeFromAsset(), AddRemoteCode()
    ]);

  Widget buildElement(ContentPiece data) {
    var result = this.execute<Widget>({'data': data});
    return result.isEmpty ? null : result.first;
  }
}
