import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/share_button.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class AddCode extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    final code = context.properties["code"];
    
    return Column(
      children: [
        HaskellCode(code),
        ShareButton(),
      ],
    );
  }
}