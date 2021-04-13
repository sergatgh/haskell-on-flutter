import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

import 'processors.dart';

class BuildTabPipeline extends Pipeline {
  static BuildTabPipeline instance = BuildTabPipeline();
  BuildTabPipeline() : super([
    BuildElements(), CreateTabWidget()
  ]);

  Widget getTab(List<ContentPiece> data, Widget Function(List<Widget>) wrapper) {
    var result = this.execute<Widget>({'data': data, 'wrapper': wrapper });
    return result;
  }
}
