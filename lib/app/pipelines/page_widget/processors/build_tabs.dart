import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_widget/build_tab_pipeline.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class BuildTabs extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as PageDefinition;

    var tabs = <Widget>[];

    for (var value in contents.tabs) {
      var tabPieces = BuildTabPipeline.instance.getTab(value.pieces);

      tabs.add(ListView(
        children: tabPieces,
        padding: EdgeInsets.all(16.0),
      ));
    }

    context.properties["tabBar"] = TabBarView(
      children: tabs,
    );
  }
}
