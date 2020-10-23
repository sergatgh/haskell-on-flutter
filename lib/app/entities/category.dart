class Category {
  final String icon;
  final String title;
  final String topic;

  Category(this.title, this.icon, {this.topic = "Other"});
}

class JsonCategory extends Category {
  final List<dynamic> json;
  JsonCategory(this.json, String title, String icon, {String topic = "Other"})
      : super(title, icon, topic: topic);
}

class SqlCategory extends Category {
  final int id;
  SqlCategory(this.id, String title, String icon, {String topic = "Other"})
      : super(title, icon, topic: topic);
}
