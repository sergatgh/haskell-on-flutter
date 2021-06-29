import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/category_list_view.dart';
import './search/content_search.dart';
import 'package:sqflite/sqflite.dart';

class CategoryListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return buildListView(context);
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Haskell is Awesome'),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.delete_forever),
        //   onPressed: () {
        //     getDatabasesPath()
        //       .then((value) => value + '/content.db')
        //       .then((value) => deleteDatabase(value))
        //       .then((value) => this.refresh?.call());
        //   },
        // ),
        // IconButton(
        //   icon: Icon(Icons.system_update_alt),
        //   onPressed: () {
        //     this.refresh?.call();
        //   }
        // ),
        // IconButton(
        //   icon: Icon(Icons.search),
        //   onPressed: () {
        //     showSearch(
        //         context: context,
        //         delegate: ContentSearch(categories: categories));
        //   },
        // )
      ],
    );
  }
}
