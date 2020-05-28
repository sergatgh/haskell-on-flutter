import 'package:flutter/widgets.dart';

class ContentPageData {

  final Icon icon;
  final String title;
  final List<String> files;
  String category;

  ContentPageData({this.icon, this.title, this.files, this.category = "Other"});

}
