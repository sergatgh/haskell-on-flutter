import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/add_code.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/add_share_button.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/processors/wrap_tab.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class BuildTabPipeline extends Pipeline {
  BuildTabPipeline() : super([
    AddCode(), AddShareButton(), WrapTab()
  ]);

  Future<Widget> getTab(String code) {
    return this.execute<Widget>({'code': code}).then((value) => value[0]);
  }
}
