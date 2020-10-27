
// Element on the tab
class ContentPiece {
  final String type;
  final String data;

  ContentPiece(this.type, this.data);
}

class SearchContentPiece extends ContentPiece {
  SearchContentPiece(String type, String data) : super(type, data);
}
