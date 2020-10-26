import 'package:haskell_is_beautiful/app/pipelines/search_content/processors/CheckInFiles.dart';
import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class ContentFinder extends AsyncPipeline {
  ContentFinder() : super([CheckContentInFiles()]);

  Future<List<ContentPiece>> checkContent(Category link, String searchContent) {
    return this.execute<List<ContentPiece>>({"link": link, "search": searchContent});
  }
}
