import 'package:flutter/material.dart';

class JournalViewModel {
  final String identifier;
  final String title;
  final String icon;
  final Color primaryColor;

  JournalViewModel(this.identifier, this.title, this.icon,
      {this.primaryColor = const Color.fromARGB(255, 240, 93, 112)});

  
  static JournalViewModel fromMap(Map<String, dynamic> json) {
    
    var identifier = "";
    if (json.containsKey("id")) {
      identifier = json["id"].toString();
    }

    var title = "Unnamed journal";
    if (json.containsKey("title")) {
      title = json["title"];
    }

    String icon = "ac_unit";
    if (json.containsKey("icon")) {
      icon = json["icon"];
    }

    return JournalViewModel(identifier, title, icon);
  }

}
