import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:icons_helper/icons_helper.dart';

class BuildNavigationBar extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    var pageDefinition = context.properties["contents"] as PageDefinition;
    var title = pageDefinition.title;

    AppBar appBar;

    if (pageDefinition.tabs.length > 1) {
      appBar = AppBar(
          title: Text(title),
          bottom: TabBar(
            tabs: buildNavigationBar(pageDefinition),
          ));
    } else {
      appBar = AppBar(
        title: Text(title),
      );
    }

    context.properties["appBar"] = appBar;
  }

  List<Widget> buildNavigationBar(PageDefinition pageDefinition) {
    var icons = [
      Icons.looks_one,
      Icons.looks_two,
      Icons.looks_3,
      Icons.looks_4,
      Icons.looks_5,
      Icons.looks_6,
    ];
    var tabs = <Tab>[];

    for (var i = 0; i < pageDefinition.tabs.length; i++) {
      var icon = pageDefinition.tabs[i].icon;

      var tabIcon = Icon(Icons.library_books);
      if (icon == null || getIconUsingPrefix(name: icon) == null) {
        if (i < icons.length) {
          tabIcon = Icon(icons[i]);
        }
      } else {
        tabIcon = Icon(getIconUsingPrefix(name: icon));
      }

      tabs.add(Tab(
        icon: tabIcon,
      ));
    }

    return tabs;
  }
}
