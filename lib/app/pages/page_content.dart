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
  BuildContentPage builder = BuildContentPage();
  List<ContentData> data = [];

  @override
  void initState() {
    super.initState();

    Future.wait(widget.content.files
            .map((file) => widget.contentManager.getContent(rootBundle, file)))
        .then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return builder.getPage(data, widget.content.title);
  }
}
