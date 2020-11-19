import 'package:flutter/material.dart';

class TaskListViewModel {
  final String identifier;
  final String title;
  final String icon;
  final Color primaryColor;

  TaskListViewModel(this.identifier, this.title, this.icon,
      {this.primaryColor = const Color.fromARGB(255, 240, 93, 112)});
}
