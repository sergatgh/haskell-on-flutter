
class Category {
  final String icon;
  final String title;
  final String category;
  final List<dynamic> json;

  Category(this.json, this.title, this.icon, {this.category = "Other"});
}
