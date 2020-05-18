import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities/content_manager.dart';
import 'package:haskell_is_beautiful/app/main_content.dart';
import 'package:haskell_is_beautiful/app/page_content.dart';

class HaskellPocketBookApp extends StatelessWidget {
  final ContentManager contentManager;

  HaskellPocketBookApp(this.contentManager);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getHome(),
      routes: getRoutes(),
    );
  }

  Widget getHome() {
      return ListOfCategories(
        categories: this.contentManager.contents,
      );
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    var map = Map.fromIterable(this.contentManager.contents,
        key: (c) => c.title as String,
        value: (c) => (BuildContext context) => ContentPage(
              content: c,
            ));

    return map;
  }
}
