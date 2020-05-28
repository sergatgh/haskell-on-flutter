import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ShareButton extends StatelessWidget {
  final String content;

  const ShareButton({this.content});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text("Share"), onPressed: () => Share.share(content));
  }
}
