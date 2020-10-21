import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/share_button.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class AddCode extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    final content = context.properties["data"] as ContentPiece;
    
    return Column(
      children: [
        HaskellCode(content.data),
        ShareButton(content: content.data),
      ],
    );
  }

  @override
  bool safeCondition(PipelineContext context) {
    final content = context.properties["data"] as ContentPiece;

    return content.type == ContentType.code;
  }
}