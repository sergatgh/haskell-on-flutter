import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/content_page/processors/build_navigation_bar.dart';
import 'package:haskell_is_beautiful/app/components/content_page/processors/build_tabs.dart';
import 'package:haskell_is_beautiful/app/components/content_page/processors/wrap_page.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class BuildContentPage extends Pipeline {
  BuildContentPage() : super([
    BuildNavigationBar(), BuildTabs(), WrapPage()
  ]);

  Future<Widget> getPage(List<ContentData> contents, String title) {
    return this.execute<Widget>({'contents': contents, 'title': title}).then((x) => x[0]);
  }
}