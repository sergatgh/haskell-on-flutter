class ContentContainer {
  final List<ContentResource> resources;

  ContentContainer({this.resources});

}

// JSON category
class ContentResource {
  final String icon;
  final String title;
  final String category;
  final List<dynamic> data;

  ContentResource(this.data, this.title, this.icon, {this.category = "Other"});
}
