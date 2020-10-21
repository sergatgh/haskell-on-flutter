
class Category {
  final String icon;
  final String title;
  final String category;
  final List<dynamic> data;

  Category(this.data, this.title, this.icon, {this.category = "Other"});
}
