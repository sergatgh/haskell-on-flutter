import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/add_code.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/wrap_tab.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/entities/content.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildTabPipeline extends Pipeline {
  BuildTabPipeline() : super([AddCode(), WrapTab()]);

  Widget getTab(ContentData data) {
    var code = data.content.firstWhere(
        (element) => element.type == ContentType.code,
        orElse: () => null);
    return this.execute<Widget>({'code': code.data})[0];
  }
}
