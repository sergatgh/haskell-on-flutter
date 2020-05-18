import 'package:haskell_is_beautiful/app/entities/content_link.dart';

class ContentManager {
  final List<ContentPageData> contents;

  ContentManager(this.contents);

  List<String> getCategories(String parent) {
    return contents.map((x) => x.title).toList();
  }
}
