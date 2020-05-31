import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haskell_is_beautiful/app/entities/content_link.dart';

class CategoryListView extends StatelessWidget {
  final List<ContentLink> categories;

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

  Widget buildLink(BuildContext context, ContentLink content) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
