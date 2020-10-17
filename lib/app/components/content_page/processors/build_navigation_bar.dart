import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:icons_helper/icons_helper.dart';

class BuildNavigationBar extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    var contents = context.properties["contents"] as List<ContentData>;
    var title = context.properties["title"] as String;

    AppBar appBar;

    if (contents.length > 1) {
      appBar = AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: buildNavigationBar(contents),
          ));
    } else {
      appBar = AppBar(
        title: Text(title),
      );
    }

    context.properties["appBar"] = appBar;

    return null;
  }

  List<Widget> buildNavigationBar(List<ContentData> contentTabsData) {
    var icons = [
      Icons.looks_one,
      Icons.looks_two,
      Icons.looks_3,
      Icons.looks_4,
      Icons.looks_5,
      Icons.looks_6,
    ];
    var tabs = <Tab>[];

    for (var i = 0; i < contentTabsData.length; i++) {
      var icon;

      var tabIcon = Icon(Icons.library_books);
      if (icon == null) {
          if (i < icons.length) {
            tabIcon = Icon(icons[i]);
          }
      }
      else {
        tabIcon = Icon(getIconUsingPrefix(name: icon));
      }

      tabs.add(Tab(
        icon: tabIcon,
      ));
    }

    return tabs;
  }
}
