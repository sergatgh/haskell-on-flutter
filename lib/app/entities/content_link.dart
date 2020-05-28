import 'package:flutter/widgets.dart';

class ContentLink {

  final Icon icon;
  final String title;
  final List<String> files;
  String category;

  ContentLink({this.icon, this.title, this.files, this.category = "Other"});

}
