class Provider {
  final int id;
  final String title;
  final String link;
  final String icon;

  Provider(this.id, this.title, this.link, this.icon);

  static Provider fromMap(Map<String, dynamic> entity) {
    var id = 0;
    if (entity.containsKey("id")) {
      id = entity["id"];
    }

    var title = "";
    if (entity.containsKey("title")) {
      title = entity["title"];
    }
    var link = "";
    if (entity.containsKey("link")) {
      link = entity["link"];
    }

    var icon = "";
    if (entity.containsKey("icon")) {
      icon = entity["icon"];
    }

    return Provider(id, title, link, icon);
  }
}
