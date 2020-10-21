import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/tab_content/build_tab_pipeline.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildTabs extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as PageDefinition;

    var tabs = <Widget>[];

    for (var value in contents.tabs) {
      var tab = BuildTabPipeline().getTab(value);
      tabs.add(tab);
    }

    context.properties["tabBar"] = TabBarView(
      children: tabs,
    );

    return null;
  }
}
