import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class WrapPage extends Processor {
  @override
  Future<Object> safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as List<ContentData>;
    var tabBar = context.properties["tabBar"] as TabBarView;
    var appBar = context.properties["appBar"] as AppBar;

    var result = DefaultTabController(
        length: contents.length,
        child: Scaffold(
          // backgroundColor: Theme.of(context).backgroundColor,
          appBar: appBar,
          body: tabBar,
        ));
    
    return Future.value(result);
  }
}
