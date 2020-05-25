import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'entities/content_link.dart';

class ListOfCategories extends StatelessWidget {
  final List<ContentPageData> categories;

  ListOfCategories({this.categories});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(),
      body: buildListView(context),
    );
  }

  ListView buildListView(BuildContext context) {
    return ListView(
          children: this.categories.map(
            (c) => buildLink(context, c)).toList());
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Haskell is Awesome'),
    );
  }

  Widget buildLink(BuildContext context, ContentPageData content) {
    return ListTile(
        leading: content.icon,
        title: Text(content.title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).pushNamed(content.title);
        });
  }
}
