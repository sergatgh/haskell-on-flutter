import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';

class HomeDataProvider extends InheritedWidget {
  
  final List<JournalViewModel> journals;

  HomeDataProvider({
    Widget child,
    this.journals,
  }) : super(child: child);

  @override
  bool updateShouldNotify(HomeDataProvider oldWidget) => this.journals != oldWidget.journals;
  static HomeDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeDataProvider>();
}
