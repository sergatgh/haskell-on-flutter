import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';
import 'package:haskell_is_beautiful/app/pages/loading/initial_content_loader.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages.dart';
import 'package:haskell_is_beautiful/app/pipelines.dart';

import 'pages/journals/page.dart';

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
  List<JournalViewModel> journals = [];
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
    }).then((value) => this.getJournals());
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

  Future getJournals() {
    return GetJournalsPreviews.instance
        .getContent()
        .then((value) => this.setState(() {
              this.journals = value;
            }));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JouranlsOverview(
        reloadData: this.loadDataFromWeb,
        journals: this.journals,
      ),
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

  Widget getHome(BuildContext context) {
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
    Map<String, Widget Function(BuildContext)> map = Map.fromIterable(
        this.contentPageData == null ? [] : this.contentPageData.resources,
        key: (c) => c.title as String,
        value: (c) => (BuildContext context) => ContentPage(
              content: c,
            ));

    map.putIfAbsent("journal", () => getHome);

    return map;
  }
}
