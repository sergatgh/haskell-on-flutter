import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';
import 'package:haskell_is_beautiful/app/pages/loading/initial_content_loader.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pages.dart';
import 'package:haskell_is_beautiful/app/pipelines.dart';
import 'package:haskell_is_beautiful/app/providers/HomeDataProvider.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

import 'pages/categories/pipelines/get_categories/categories_builder.dart';
import 'pages/journals/page.dart';
import 'pages/journals/pipelines/get_journals_previews/get_journals.dart';
import 'pipelines/router/create_router.dart';

class HaskellPocketBookApp extends StatefulWidget {
  HaskellPocketBookApp();

  @override
  State<StatefulWidget> createState() {
    return HaskellPocketBookAppState();
  }
}

class HaskellPocketBookAppState extends State<HaskellPocketBookApp> {
  CategoriesBuilder topicRetriever = CategoriesBuilder();
  List<JournalViewModel> journals = [];

  @override
  void initState() {
    super.initState();

    this.getJournals()
      .then((value) => getRoutes(value));
  }

  Future getJournals() {
    return GetJournalsPreviews.instance
        .getContent()
        .then((value){ this.setState(() {
              this.journals = value;
            }); return value;});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getStartScreen(),
      onGenerateRoute: UpdateRouter.instance.generateRoute,
      theme: getThemeData(),
    );
  }

  Widget getStartScreen() {
    return HomeDataProvider(
      child: JouranlsOverview(
      ),
      journals: this.journals,
    );
  }

  ThemeData getThemeData() {
    return ThemeData(
        primaryColor: Color.fromARGB(255, 41, 62, 93),
        backgroundColor: Color.fromARGB(255, 244, 244, 244));
  }
}
