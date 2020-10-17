
class ContentPiece {
  final ContentType type;
  final String data;

  ContentPiece(this.type, this.data);
}

enum ContentType {
  icon,
  code,
  markdown,
  text
}
