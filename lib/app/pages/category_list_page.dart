import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/category_list_view.dart';
import 'package:haskell_is_beautiful/app/components/content_search.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';

class CategoryListPage extends StatelessWidget {
  final ContentContainer categories;

  CategoryListPage({this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: buildListView(context),
    );
  }

  Widget buildListView(BuildContext context) {
    if (this.categories == null || this.categories.resources == null) {
      return CategoryListView(categories: [],);
    }
    return CategoryListView(categories: this.categories.resources);
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Haskell is Awesome'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(
                context: context,
                delegate: ContentSearch(categories: categories));
          },
        )
      ],
    );
  }
}



