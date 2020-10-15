import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/build_tab_pipeline.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class BuildTabs extends Processor {
  @override
  Future<Object> safeExecute(PipelineContext context) async {
    var contents = context.properties["contents"] as List<ContentData>;

    var tabs = <Widget>[];

    for (var value in contents) {
      var tab = await BuildTabPipeline().getTab(value.content);
      tabs.add(tab);
    }

    context.properties["tabBar"] = TabBarView(
      children: tabs,
    );

    return Future.value(null);
  }
}
