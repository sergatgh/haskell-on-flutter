import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pages/initial_content_loader.dart';
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
  String status = "";

  @override
  void initState() {
    super.initState();

    this.updateStatus("Checking last update.");
    Settings.lastUpdate().then((lastUpdate) {
      if (lastUpdate == null) {
        this.loadDataFromWeb();
      } else {
        var date = DateTime.tryParse(lastUpdate);
        if (date == null ||
            date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
          this.loadDataFromWeb();
        } else {
          getTopics();
        }
      }
    });
  }

  void updateStatus(String message) {
    this.setState(() {
      this.status = message;
    });
  }

  Future downloadTopics() async {
    await downloader.download([(msg) => updateStatus(msg.message)]);
  }

  Future getTopics() {
    updateStatus("Content is loaded, preparing data.");
    return topicRetriever.getTopics(rootBundle).then((value) {
      setState(() {
        contentPageData = value;
        this.status = "";
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
    });

    this.downloadTopics().then((_) => this.getTopics());
  }

  Widget getHome() {
    if (this.status.isNotEmpty) {
      return InitialContentLoader(
        message: this.status,
      );
    }
    return CategoryListPage(
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
