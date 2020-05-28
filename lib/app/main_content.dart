import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'entities/content_link.dart';

class CategoryListPage extends StatelessWidget {
  final List<ContentPageData> categories;

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
    return CategoryListView(categories: this.categories);
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

class CategoryListView extends StatelessWidget {
  final List<ContentPageData> categories;

  CategoryListView({this.categories});

  @override
  Widget build(BuildContext context) {
    return GroupedListView(
      elements: this.categories,
      groupBy: (element) => element.category,
      groupSeparatorBuilder: _buildGroupSeparator,
      itemBuilder: (context, element) => buildLink(context, element),
      order: GroupedListOrder.ASC,
    );
  }

  Widget _buildGroupSeparator(dynamic groupByValue) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(
        groupByValue,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )),
    );
  }

  Widget buildLink(BuildContext context, ContentPageData content) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: content.icon,
            title: Text(content.title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).pushNamed(content.title);
            }),
      ),
    );
  }
}

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
