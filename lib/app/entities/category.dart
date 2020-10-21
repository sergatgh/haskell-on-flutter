
class Category {
  final String icon;
  final String title;
  final String topic;
  final List<dynamic> json;

  Category(this.json, this.title, this.icon, {this.topic = "Other"});
}
