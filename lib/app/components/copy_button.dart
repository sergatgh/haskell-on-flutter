import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String content;

  const CopyButton({this.content});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text("Copy"),
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: content));
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Copied to clipboar."),
          ));
        });
  }
}
