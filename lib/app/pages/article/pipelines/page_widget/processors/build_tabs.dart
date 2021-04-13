import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages/article/pipelines/tab_widget/build_tab_pipeline.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildTabs extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as PageDefinition;

    var tabs = <Widget>[];

    for (var value in contents.tabs) {
      var tab = BuildTabPipeline.instance.getTab(
          value.pieces,
          (content) => ListView(
                children: content,
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              ));

      tabs.add(tab);
    }

    context.properties["tabBar"] = TabBarView(
      children: tabs,
    );
  }
}
