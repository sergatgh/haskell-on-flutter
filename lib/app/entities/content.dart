

import 'dart:io';

import 'package:haskell_is_beautiful/app/entities/content_piece.dart';

class ContentData {
  final List<ContentPiece> content;

  ContentData(this.content);

  List<String> getAll(ContentType contentType) {
    return content.where((element) => element.type == contentType).map((e) => e.data);
  }
  
  String getOne(ContentType contentType) {
    var element = content.firstWhere((element) => element.type == contentType, orElse: () => null);
    if (element == null) {
      return null;
    }

    return element.data;
  }
}
