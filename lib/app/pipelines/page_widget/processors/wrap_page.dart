import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class WrapPage extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    var contents = context.get<PageDefinition>("contents");
    var tabBar = context.get<TabBarView>("tabBar");
    var appBar = context.get<AppBar>("appBar");
    var buildContext = context.get<BuildContext>("buildContext");

    var result = DefaultTabController(
        length: contents.tabs.length,
        child: Scaffold(
          backgroundColor: Theme.of(buildContext).backgroundColor,
          appBar: appBar,
          body: tabBar,
        ));
    
    context.setResult(result);
  }
}
