import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'background_data_provider.dart';
import 'home_background.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  final Function refresh;

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

  const HomePage({Key key, this.refresh}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = HomePage.colors[0];
  Widget page;

  @override
  Widget build(BuildContext context) {
    return HomeBackground(colors: colors, child: buildPage(context));
  }

  void changeColors(int number) {
    var length = HomePage.colors.length;
    var colorNumber = number % length;
    setState(() {
      colors = HomePage.colors[colorNumber];
    });
  }

  Widget buildPage(BuildContext context) {
    return this.page ??
        (this.page = Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(context),
          body: buildBody(context),
        ));
  }

  Widget buildBody(BuildContext context) {
    return BackgroundDataProvider(
        changeColor: changeColors, child: HomePageContent());
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      elevation: 0.0,
      title: Center(child: Text('HASKELL IS BEAUTIFUL')),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            getDatabasesPath()
                .then((value) => value + '/content.db')
                .then((value) => deleteDatabase(value))
                .then((value) => this.widget.refresh?.call());
          },
        ),
        // SEARCH
        //IconButton(icon: Icon(Icons.search), onPressed: () {})
      ],
      backgroundColor: Colors.transparent,
    );
  }
}
