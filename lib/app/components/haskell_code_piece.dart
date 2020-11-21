import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/copy_button.dart';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: CopyButton(content: this.content)),
            Expanded(child: ShareButton(content: this.content)),
          ],
        ),
      ],
    );
  }
}
