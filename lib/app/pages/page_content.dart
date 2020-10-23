import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/pipelines/page_widget/build_content_page.dart';
import 'package:haskell_is_beautiful/app/pipelines/get_category_content/get_page_definition.dart';
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
  GetCategoryContent dataRetriever = GetCategoryContent.instance;
  PageDefinition pageDefinition = PageDefinition("Loading...", []);

  @override
  void initState() {
    super.initState();

      dataRetriever.getContent(widget.content)
        .then((value) => setState(() {
              pageDefinition = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return pageWidgetBuilder.getPage(pageDefinition);
  }
}
