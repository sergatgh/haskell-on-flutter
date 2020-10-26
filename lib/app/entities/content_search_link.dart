import 'package:haskell_is_beautiful/app/entities/category.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';

class ContentSearchLink extends Category {
  final List<ContentPiece> foundContent;

  ContentSearchLink._internal(String icon, String title, String category, this.foundContent) : super(title, icon, topic: category);
  
  factory ContentSearchLink(Category link, List<ContentPiece> code) {
    return ContentSearchLink._internal(link.icon, link.title, link.topic, code);
  }
}