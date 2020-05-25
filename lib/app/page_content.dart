import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:share/share.dart';

import 'entities/content.dart';
import 'entities/content_link.dart';

class ContentPage extends StatelessWidget {
  final ContentPageData content;

  ContentPage({this.content});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: content.contents.length,
      child: Scaffold(
        appBar: buildNavigationBar(),
        body: TabBarView(
            children: content.contents.map((c) => buildTab(c)).toList()),
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
    if (content.contents.length > 1) {
      var icons = [
        Icons.looks_one,
        Icons.looks_two,
        Icons.looks_3,
        Icons.looks_4,
        Icons.looks_5,
        Icons.looks_6,
      ];
      var tabs = <Tab>[];

      for (var i = 0; i < content.contents.length; i++) {
        var page = content.contents[i];
        tabs.add(Tab(icon: page.icon ?? Icon(icons[i])));
      }

      return AppBar(
        bottom: TabBar(
          tabs: tabs,
        ),
        title: Text(content.title),
      );
    } else {
      return AppBar(
        title: Text(content.title),
      );
    }
  }
}