import 'package:flutter/widgets.dart';

class ContentLink {

  final Icon icon;
  final String title;
  final List<ContentResource> resources;
  String category;

  ContentLink({this.icon, this.title, this.resources, this.category = "Other"});

}

class ContentResource {
  final String icon;
  final ResourceType resourceType;
  final String link;

  ContentResource(this.resourceType, this.link, {this.icon});
}

enum ResourceType {
  json,
  file,
  link
}