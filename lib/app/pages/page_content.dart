import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/content_page/build_content_page.dart';
import 'package:haskell_is_beautiful/app/entities.dart';

class ContentPage extends StatefulWidget {
  final ContentManager contentManager;
  final ContentLink content;

  ContentPage({this.contentManager, this.content});

  @override
  State<StatefulWidget> createState() {
    return ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  Widget page = Container(
    width: 0,
    height: 0,
  );

  @override
  void initState() {
    super.initState();

    Future.wait(widget.content.files
            .map((file) => widget.contentManager.getContent(rootBundle, file)))
        .then(
            (value) => BuildContentPage().getPage(value, widget.content.title))
        .then((value) {
      setState(() {
        page = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return page;
  }
}
