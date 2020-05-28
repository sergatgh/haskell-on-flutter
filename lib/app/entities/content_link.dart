import 'package:flutter/widgets.dart';
import 'package:haskell_is_beautiful/app/entities/content.dart';

class ContentPageData {

  final Icon icon;
  final String title;
  final List<String> files;
  String category;

  ContentPageData({this.icon, this.title, this.files, this.category = "Other"});

}
