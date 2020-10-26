import 'package:haskell_is_beautiful/app/entities.dart';
import 'package:haskell_is_beautiful/app/pipelines/download_from_url/download_content.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class ReplaceRemotePieces extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var page = context.get<PageDefinition>("result");
    for (var tab in page.tabs) {
      for (var piece in tab.pieces) {
        if (piece.type.startsWith("remote-")) {
          var index = tab.pieces.indexOf(piece);
          tab.pieces.removeAt(index);
          var element = await getCode(piece);
          tab.pieces.insert(index, element);
        }
      }
    }
  }

  @override
  bool safeCondition(PipelineContext context) {
    return context.has<PageDefinition>("result");
  }

  Future<ContentPiece> getCode(ContentPiece remote) async {
    var content = await DownloadContent.instance.download(remote.data);
    return ContentPiece(remote.type.replaceAll("remote", "raw"), content);
  }
}
