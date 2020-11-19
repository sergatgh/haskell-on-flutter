import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final Widget child;
  final List<Color> colors;

  HomeBackground({
    this.child,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: this.colors,
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter)),
        duration: Duration(seconds: 1),
        curve: Curves.easeOutCubic,
        child: this.child);
  }
}
