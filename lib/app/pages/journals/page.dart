import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';

import 'components/background.dart';
import 'components/body.dart';

class JouranlsOverview extends StatefulWidget {
  final Function reloadData;
  final List<JournalViewModel> journals;

  static List<List<Color>> colors = [
    [
      Color.fromARGB(255, 240, 93, 112),
      Color.fromARGB(255, 249, 167, 84),
    ],
    [
      Color.fromARGB(255, 82, 107, 231),
      Color.fromARGB(255, 99, 173, 239),
    ],
  ];

  const JouranlsOverview({this.reloadData, this.journals = const []})
      : super(key: const ObjectKey(const []));

  @override
  _JouranlsOverviewState createState() => _JouranlsOverviewState();
}

class _JouranlsOverviewState extends State<JouranlsOverview> {
  List<Color> colors = JouranlsOverview.colors[0];

  @override
  Widget build(BuildContext context) {
    return Background(colors: colors, child: buildPage(context));
  }

  void changeColors(int number) {
    var length = JouranlsOverview.colors.length;
    var colorNumber = number % length;
    setState(() {
      colors = JouranlsOverview.colors[colorNumber];
    });
  }

  Widget buildPage(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(context),
          body: buildBody(context),
        );
  }

  Widget buildBody(BuildContext context) {
    return Body(
      onPageChanged: this.changeColors,
      journals: widget.journals,
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      // leading: Icon(Icons.menu),
      elevation: 0.0,
      title: Center(child: Text('HASKELL POCKET BOOK')),
      // actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.delete_forever),
      //     onPressed: () {
      //       getDatabasesPath()
      //           .then((value) => value + '/content.db')
      //           .then((value) => deleteDatabase(value))
      //           .then((value) => this.widget.refresh?.call());
      //     },
      //   ),
      //   // SEARCH
      //   //IconButton(icon: Icon(Icons.search), onPressed: () {})
      // ],
      backgroundColor: Colors.transparent,
    );
  }
}
