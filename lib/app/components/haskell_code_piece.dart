import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/share_button.dart';

class HaskellCodePiece extends StatelessWidget {
  final String content;

  HaskellCodePiece(this.content) : super(key: ObjectKey(content));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HaskellCode(this.content),
        ShareButton(content: this.content),
      ],
    );
  }
}
