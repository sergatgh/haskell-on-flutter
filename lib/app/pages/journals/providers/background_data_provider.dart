import 'package:flutter/material.dart';

class BackgroundDataProvider extends InheritedWidget {
  final void Function(int) changeColor;

  BackgroundDataProvider({
    @required Widget child,
    @required this.changeColor,
  }) : super(child: child);

  @override
  bool updateShouldNotify(BackgroundDataProvider oldWidget) =>
      changeColor != oldWidget.changeColor;

  static BackgroundDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BackgroundDataProvider>();
}
