import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/add_code.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/add_share_button.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/wrap_tab.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class BuildTabPipeline extends Pipeline {
  BuildTabPipeline() : super([
    AddCode(), AddShareButton(), WrapTab()
  ]);

  Widget getTab(String code) {
    return this.execute<Widget>({'code': code})[0];
  }
}
