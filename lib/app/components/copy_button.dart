import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyButton extends StatelessWidget {
  final String content;

  const CopyButton({this.content});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text("Copy"),
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: content));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Copied to clipboar."),
          ));
        });
  }
}
