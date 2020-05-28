import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class HaskellCode extends StatelessWidget {
  final String code;

  HaskellCode(this.code);

  @override
  Widget build(BuildContext context) {
    return HighlightView(
      code,
      language: 'haskell',
      theme: githubTheme,
      padding: EdgeInsets.all(12),
      textStyle: TextStyle(
          fontFamily:
              'SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace'),
    );
  }
}