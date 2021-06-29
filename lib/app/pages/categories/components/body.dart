import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/category_list_view.dart';

import '../../../entities.dart';
import '../../../pipelines.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DownloadCategories downloader = DownloadCategories.instance;
  ContentContainer contentPageData;

  @override
  void initState() {
    super.initState();

    Settings.lastUpdate().then((lastUpdate) {
      if (lastUpdate == null) {
        this.loadDataFromWeb();
      } else {
        var date = DateTime.tryParse(lastUpdate);
        if (date == null ||
            date.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
          this.loadDataFromWeb();
        } else {
          getTopics();
        }
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return buildListView(context);
  }

  Widget buildListView(BuildContext context) {
    if (this.categories == null || this.categories.resources == null) {
      return CategoryListView(
        categories: [],
      );
    }
    return CategoryListView(categories: this.categories.resources);
  }
  
  Future getTopics() {
    return topicRetriever.getTopics(rootBundle).then((value) {
      setState(() {
        contentPageData = value;
        this.status = "";
      });
    });
  }

  void loadDataFromWeb() {
    setState(() {
      this.contentPageData = null;
    });

    this.downloadTopics().then((_) => this.getTopics());
  }
  

  Future downloadTopics() async {
    await downloader.download([(msg) => updateStatus(msg.message)]);
  }
}
