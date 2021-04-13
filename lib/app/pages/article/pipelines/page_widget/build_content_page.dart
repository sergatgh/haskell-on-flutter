import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

import 'processors.dart';

class BuildContentPage extends Pipeline {
  BuildContentPage() : super([
    BuildNavigationBar(), BuildTabs(), WrapPage()
  ]);

  Widget getPage(PageDefinition contents, BuildContext buildContext) {
    var result = this.execute<Widget>({'contents': contents, 'buildContext': buildContext});
    return result;
  }
}