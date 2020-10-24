import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/category_list_view.dart';
import 'package:haskell_is_beautiful/app/components/content_search.dart';
import 'package:haskell_is_beautiful/app/entities/content_container.dart';
import 'package:sqflite/sqflite.dart';

class CategoryListPage extends StatelessWidget {
  final ContentContainer categories;
  final Function refresh;

  CategoryListPage({this.categories, this.refresh});

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
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            getDatabasesPath()
              .then((value) => value + '/content.db')
              .then((value) => deleteDatabase(value))
              .then((value) => this.refresh?.call());
          },
        ),
        IconButton(
          icon: Icon(Icons.system_update_alt),
          onPressed: () {
            this.refresh?.call();
          }
        ),
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



