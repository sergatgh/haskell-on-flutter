import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';
import 'package:haskell_is_beautiful/app/entities/content_manager.dart';
import 'package:haskell_is_beautiful/app/main_content.dart';
import 'package:haskell_is_beautiful/app/page_content.dart';

class HaskellPocketBookApp extends StatefulWidget {
  final ContentManager contentManager;

  HaskellPocketBookApp(this.contentManager);

  @override
  State<StatefulWidget> createState() {
    return HaskellPocketBookAppState();
  }
}

class HaskellPocketBookAppState extends State<HaskellPocketBookApp> {
  
  List<ContentPageData> contentPageData = [];

  @override
  void initState() {
    super.initState();

    widget.contentManager.getContents(rootBundle).then((value) {
      setState(() {
        contentPageData = value;
      });
    });

  }

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
        categories: this.contentPageData,
      );
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    var map = Map.fromIterable(this.contentPageData,
        key: (c) => c.title as String,
        value: (c) => (BuildContext context) => ContentPage(
              content: c,
            ));

    return map;
  }


}