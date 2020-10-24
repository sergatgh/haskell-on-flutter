import 'package:haskell_is_beautiful/app/entities/content_piece.dart';

// Tab
class TabDefinition {
  final String icon;
  final List<ContentPiece> pieces;

  TabDefinition(this.pieces, {this.icon});

  Iterable<String> getAll(String contentType) {
    return getAllPieces(contentType)
        .map((e) => e.data)
        .toList();
  }

  Iterable<ContentPiece> getAllPieces(String contentType) {
    return pieces
        .where((element) => element.type == contentType)
        .toList();
  }

  String getOne(String contentType) {
    var element = pieces.firstWhere((element) => element.type == contentType,
        orElse: () => null);
    if (element == null) {
      return null;
    }

    return element.data;
  }
}
