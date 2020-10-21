import 'package:haskell_is_beautiful/app/entities/category.dart';

class ContentSearchLink {
  final String icon;
  final String title;
  final String category;
  final String codeSample;

  ContentSearchLink._internal(this.icon, this.title, this.category, this.codeSample);
  
  factory ContentSearchLink(Category link, String code) {
    return ContentSearchLink._internal(link.icon, link.title, link.category, code);
  }
}