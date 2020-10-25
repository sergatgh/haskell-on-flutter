import 'package:recase/recase.dart';

class Category {
  final String icon;
  final String title;
  final String topic;

  Category(this.title, this.icon, {this.topic = "Other"});

  bool hasUpdates() {
    return false;
  }
}

class JsonCategory extends Category {
  final List<dynamic> json;
  JsonCategory(this.json, String title, String icon, {String topic = "Other"})
      : super(title, icon, topic: topic);
}

class SqlCategory extends Category {
  final int id;
  final DateTime created;
  final DateTime updated;
  final DateTime viewed;

  SqlCategory(this.id, String title, String icon,
      {String topic = "Other", this.created, this.updated, this.viewed})
      : super(title, icon, topic: topic);

  static SqlCategory fromMap(Map<String, dynamic> json) {
    var category = "Other";
    if (json.containsKey("category")) {
      category = json["category"];
    }

    var title = "Interesting code";
    if (json.containsKey("title")) {
      String result = json["title"];
      ReCase rc = new ReCase(result);
      title = rc.titleCase;
    }

    int id = 0;
    if (json.containsKey("id")) {
      id = json["id"];
    }

    String icon = "ac_unit";
    if (json.containsKey("icon")) {
      icon = json["icon"];
    }

    DateTime created;
    if (json.containsKey("created") && json["created"] != null) {
      created = DateTime.tryParse(json["created"]);
    }

    DateTime updated;
    if (json.containsKey("updated") && json["updated"] != null) {
      updated = DateTime.tryParse(json["updated"]);
    }

    DateTime viewed;
    if (json.containsKey("viewed") && json["viewed"] != null) {
      viewed = DateTime.tryParse(json["viewed"]);
    }

    return SqlCategory(id, title, icon,
        topic: category, created: created, updated: updated, viewed: viewed);
  }

  @override
  bool hasUpdates() {
    return viewed == null || updated.isAfter(viewed);
  }
}
