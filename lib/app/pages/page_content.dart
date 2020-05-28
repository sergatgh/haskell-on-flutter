import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:haskell_is_beautiful/app/entities/content.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';
import 'package:haskell_is_beautiful/app/entities/content_manager.dart';
import 'package:share/share.dart';


class ContentPage extends StatefulWidget {
  final ContentManager contentManager;
  final ContentPageData content;

  ContentPage({this.contentManager, this.content});

  @override
  State<StatefulWidget> createState() {
    return ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  List<ContentData> contentTabsData = [];

  @override
  void initState() {
    super.initState();

    Future.wait(widget.content.files
            .map((file) => widget.contentManager.getContent(rootBundle, file)))
        .then((value) => setState(() {
              contentTabsData = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: contentTabsData.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: buildNavigationBar(),
        body: TabBarView(
            children: contentTabsData.map((c) => buildTab(c)).toList()),
      ),
    );
  }

  Widget buildTab(ContentData contentData) {
    return ListView(
      children: [
        buildCode(contentData.content),
        FlatButton(
            child: Text("Share"),
            onPressed: () => Share.share(contentData.content))
      ],
      padding: EdgeInsets.all(16.0),
    );
  }

  Widget buildCode(String code) {
    return HighlightView(
      code,
      language: 'haskell',
      theme: githubTheme,
      padding: EdgeInsets.all(12),
      textStyle: TextStyle(
          fontFamily:
              'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace'),
    );
  }

  Widget buildNavigationBar() {
    if (contentTabsData.length > 1) {
      var icons = [
        Icons.looks_one,
        Icons.looks_two,
        Icons.looks_3,
        Icons.looks_4,
        Icons.looks_5,
        Icons.looks_6,
      ];
      var tabs = <Tab>[];

      for (var i = 0; i < contentTabsData.length; i++) {
        var page = contentTabsData[i];
        var icon = page.icon;
        if (icon == null) {
          if (i < icons.length) {
            icon = Icon(icons[i]);
          } else {
            icon = Icon(Icons.library_books);
          }
        }

        tabs.add(Tab(
          icon: icon,
        ));
      }

      return AppBar(
        bottom: TabBar(
          tabs: tabs,
        ),
        title: Text(widget.content.title),
      );
    } else {
      return AppBar(
        title: Text(widget.content.title),
      );
    }
  }
}
