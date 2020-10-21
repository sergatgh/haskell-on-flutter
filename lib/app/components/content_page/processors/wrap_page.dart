import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class WrapPage extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as PageDefinition;
    var tabBar = context.properties["tabBar"] as TabBarView;
    var appBar = context.properties["appBar"] as AppBar;

    var result = DefaultTabController(
        length: contents.tabs.length,
        child: Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          appBar: appBar,
          body: tabBar,
        ));
    
    return result;
  }
}
