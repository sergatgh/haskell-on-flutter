import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/search_content/content_finder.dart';
import 'package:haskell_is_beautiful/app/entities.dart';

class SearchResultsWithCode extends StatefulWidget {
  final List<ContentLink> categories;
  final String query;

  SearchResultsWithCode({this.categories, this.query})
      : super(key: ObjectKey(query));

  @override
  _SearchResultsWithCodeState createState() => _SearchResultsWithCodeState();
}

class _SearchResultsWithCodeState extends State<SearchResultsWithCode> {
  ContentFinder contentFinder = ContentFinder();
  List<ContentSearchLink> searchResults = [];
  bool resultsAreMissing = false;

  @override
  void initState() {
    super.initState();
    var query = widget.query.toLowerCase();
    Future.wait(widget.categories.map((e) => search(e, query))).then((value) {
      if (value.any((element) => element)) return;
      setState(() {
        resultsAreMissing = true;
      });
    });
  }

  Future<bool> search(ContentLink item, String query) {
    return contentFinder.checkContent(rootBundle, item, query)
        .then((value) {
      if (value?.isEmpty ?? true) {
        if (item.title.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query)) {
          setState(() => searchResults.add(ContentSearchLink(item, null)));
          return true;
        }
      } else {
        setState(() => searchResults.add(ContentSearchLink(item, value)));
        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (resultsAreMissing) {
      return Center(child: Container(child: Text("No results.")));
    }

    if (searchResults.isEmpty) {
      return Center(child: Container(child: CircularProgressIndicator()));
    }

    return GroupedListView(
      elements: this.searchResults,
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

  Widget buildLink(BuildContext context, ContentSearchLink content) {
    var linkDescription = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: content.icon,
        title: Text(content.title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).pushNamed(content.title);
        });

    var column = content.codeSample?.isEmpty ?? true
        ? linkDescription
        : Column(children: <Widget>[
            linkDescription,
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: HaskellCode(content.codeSample))
          ]);

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: column,
      ),
    );
  }
}
