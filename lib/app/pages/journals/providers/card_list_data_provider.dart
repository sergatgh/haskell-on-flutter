import 'package:flutter/material.dart';

class CardListDataProvider extends InheritedWidget {
  final void Function() updateCards;

  CardListDataProvider({
    @required Widget child,
    @required this.updateCards,
  }) : super(child: child);

  @override
  bool updateShouldNotify(CardListDataProvider oldWidget) =>
      updateCards != oldWidget.updateCards;

  static CardListDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CardListDataProvider>();
}
