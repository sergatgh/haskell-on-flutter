import 'package:flutter/cupertino.dart';
import 'package:flutter/src/painting/text_span.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/haskell_syntax_highliter.dart';
import 'package:markdown/markdown.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:url_launcher/url_launcher.dart';

class AddMarkdown extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    final piece = context.get<ContentPiece>("data");

    context.setResult(Container(
      child: MarkdownBody(
        data: piece.data,
        onTapLink: (title, url, _) {
          canLaunch(url).then((value) {
            if (value) launch(url);
          });
        },
        syntaxHighlighter: HaskellSyntaxHighliter(),
      ),
    ));
  }

  @override
  bool safeCondition(PipelineContext context) {
    final piece = context.get<ContentPiece>("data");

    return piece != null && piece.type == "raw-markdown";
  }
}