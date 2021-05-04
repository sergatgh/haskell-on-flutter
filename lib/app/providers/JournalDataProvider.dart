import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/pages/journals/journal_view.dart';

class JournalDataProvider extends InheritedWidget {
  
  final JournalViewModel journal;

  JournalDataProvider({
    Widget child,
    this.journal,
  }) : super(child: child);

  @override
  bool updateShouldNotify(JournalDataProvider oldWidget) => journal != oldWidget.journal;
  static JournalDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<JournalDataProvider>();
}
