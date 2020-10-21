import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haskell_is_beautiful/app/components/get_widget_for_page_definition/build_content_page.dart';
import 'package:haskell_is_beautiful/app/components/get_category_content/get_page_definition.dart';
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
  GetCategoryContent dataRetriever = GetCategoryContent();
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
