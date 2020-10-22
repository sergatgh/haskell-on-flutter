import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/categories_builder.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages.dart';

class HaskellPocketBookApp extends StatefulWidget {

  HaskellPocketBookApp();

  @override
  State<StatefulWidget> createState() {
    return HaskellPocketBookAppState();
  }
}

class HaskellPocketBookAppState extends State<HaskellPocketBookApp> {
  
  CategoriesBuilder topicRetriever = CategoriesBuilder();
  ContentContainer contentPageData;

  @override
  void initState() {
    super.initState();

    topicRetriever.getTopics(rootBundle).then((value) {
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
      theme: getThemeData(),
    );
  }

  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 41, 62, 93),
      backgroundColor: Color.fromARGB(255, 244, 244, 244)
    );
  }

  Widget getHome() {
      return CategoryListPage(
        categories: this.contentPageData,
      );
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    var map = Map.fromIterable(this.contentPageData == null ? [] : this.contentPageData.resources,
        key: (c) => c.title as String,
        value: (c) => (BuildContext context) => ContentPage(
              content: c,
            ));

    return map;
  }


}