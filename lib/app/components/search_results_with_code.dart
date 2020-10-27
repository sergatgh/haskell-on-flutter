import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:haskell_is_beautiful/app/pipelines/search_content/content_finder.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/tab_widget/build_tab_pipeline.dart';
import 'package:icons_helper/icons_helper.dart';

class SearchResultsWithCode extends StatefulWidget {
  final ContentContainer categories;
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
    Future.wait(widget.categories.resources.map((e) => search(e, query)))
        .then((value) {
      if (value.any((element) => element)) return;
      setState(() {
        resultsAreMissing = true;
      });
    });
  }

  Future<bool> search(Category item, String query) {
    return contentFinder.checkContent(item, query).then((value) {
      if (value?.isEmpty ?? true) {
        if (item.title.toLowerCase().contains(query) ||
            item.topic.toLowerCase().contains(query)) {
          setState(() => searchResults.add(ContentSearchLink(item, [])));
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
      groupBy: (element) => element.topic,
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
        leading: Icon(getIconUsingPrefix(name: content.icon)),
        title: Text(content.title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.of(context).pushNamed(content.title);
        });

    var column = content.foundContent.isEmpty
        ? linkDescription
        : Column(children: <Widget>[
            linkDescription,
            Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children:
                        BuildTabPipeline.instance.getTab(content.foundContent)))
          ]);

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        width: double.maxFinite,
        child: column,
      ),
    );
  }
}
