import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_widget/processors/build_elements.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_widget/processors/wrap_tab.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildTabPipeline extends Pipeline {
  static BuildTabPipeline instance = BuildTabPipeline();
  BuildTabPipeline() : super([
    BuildElements(), WrapTab()
  ]);

  Widget getTab(List<ContentPiece> data, {wrap = false}) {
    var result = this.execute<Widget>({'data': data, 'wrap': wrap});
    return result;
  }
}
