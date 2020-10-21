import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/content_page/build_content_page.dart';
import 'package:haskell_is_beautiful/app/components/content_page_data/get_content_page_data.dart';
import 'package:haskell_is_beautiful/app/entities.dart';

class ContentPage extends StatefulWidget {
  final Category content;

  ContentPage({this.content});

  @override
  State<StatefulWidget> createState() {
    return ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  BuildContentPage pageWidgetBuilder = BuildContentPage();
  GetContentPageData dataRetriever = GetContentPageData();
  PageDefinition pageDefinition = PageDefinition("Loading...", []);

  @override
  void initState() {
    super.initState();

      dataRetriever.getContent(widget.content, rootBundle)
        .then((value) => setState(() {
              pageDefinition = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return pageWidgetBuilder.getPage(pageDefinition);
  }
}
