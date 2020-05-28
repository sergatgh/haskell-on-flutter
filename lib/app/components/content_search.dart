import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';

import 'category_list_view.dart';

class ContentSearch extends SearchDelegate<ContentPageData> {
  final List<ContentPageData> categories;

  ContentSearch({this.categories});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [Icon(Icons.clear)];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return CategoryListView(
        categories: this
            .categories
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CategoryListView(
        categories: this
            .categories
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList());
  }
}
