import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';

class HomeDataProvider extends InheritedWidget {
  
  final JournalViewModel Function() getJournals;

  HomeDataProvider({
    Widget child,
    this.getJournals,
  }) : super(child: child);

  @override
  bool updateShouldNotify(HomeDataProvider oldWidget) => false;
  static HomeDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeDataProvider>();
}
