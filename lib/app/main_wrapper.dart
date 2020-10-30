import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_new_categories/download_categories.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_categories/categories_builder.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_setting/settings.dart';

class HaskellPocketBookApp extends StatefulWidget {
  HaskellPocketBookApp();

  @override
  State<StatefulWidget> createState() {
    return HaskellPocketBookAppState();
  }
}

class HaskellPocketBookAppState extends State<HaskellPocketBookApp> {
  CategoriesBuilder topicRetriever = CategoriesBuilder();
  DownloadCategories downloader = DownloadCategories.instance;
  ContentContainer contentPageData;
  bool loading = false;

  @override
  void initState() {
    super.initState();

    Settings.lastUpdate().then((lastUpdate) {
      if (lastUpdate == null) {
        downloadTopics().then((_) => getTopics());
      } else {
        var date = DateTime.tryParse(lastUpdate);
        if (date == null ||
            date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
              loading = true;
          downloadTopics().then((_) => getTopics()).then((_) => loading = false);
        } else {
          getTopics();
        }
      }
    });
  }

  Future downloadTopics() {
    return downloader.download();
  }

  Future getTopics() {
    return topicRetriever.getTopics(rootBundle).then((value) {
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
        backgroundColor: Color.fromARGB(255, 244, 244, 244));
  }

  void loadDataFromWeb() {
    setState(() {
      this.contentPageData = null;
      this.loading = true;
    });

    downloader
        .download()
        .then((_) => topicRetriever.getTopics(rootBundle))
        .then((value) => setState(() {
              this.contentPageData = value;
              this.loading = false;
            }));
  }

  Widget getHome() {
    return CategoryListPage(
      loading: loading,
      categories: this.contentPageData,
      refresh: this.loadDataFromWeb,
    );
  }

  Map<String, Widget Function(BuildContext)> getRoutes() {
    var map = Map.fromIterable(
        this.contentPageData == null ? [] : this.contentPageData.resources,
        key: (c) => c.title as String,
        value: (c) => (BuildContext context) => ContentPage(
              content: c,
            ));

    return map;
  }
}
