import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/search_results_with_code.dart';
import 'package:haskell_is_beautiful/app/entities.dart';

import 'category_list_view.dart';

class ContentSearch extends SearchDelegate<ContentContainer> {
  final ContentContainer categories;

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
    return SearchResultsWithCode(
      categories: this.categories,
      query: this.query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var list = this
        .categories.resources
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()) ||
            element.category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (list.isEmpty) {
      return Center(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There are no quick suggestions. Try to click enter for full search.",
                textAlign: TextAlign.center,
              )));
    }

    return CategoryListView(categories: list);
  }
}
