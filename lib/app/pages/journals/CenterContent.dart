import 'package:flutter/material.dart';

class CenterContent extends StatelessWidget {
  final Widget child;

  const CenterContent({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width * 0.8, 
          child: this.child,
      ),
    );
  }
}