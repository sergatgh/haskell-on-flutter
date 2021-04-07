import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  LinearGradientMask({this.child, this.begin, this.end});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
              colors: [
            Color.fromARGB(255, 240, 93, 112),
            Color.fromARGB(255, 249, 167, 84),
          ],
              begin: this.begin ?? FractionalOffset.bottomCenter,
              end: this.end ?? FractionalOffset.topCenter)
          .createShader(bounds),
      child: child,
    );
  }
}
