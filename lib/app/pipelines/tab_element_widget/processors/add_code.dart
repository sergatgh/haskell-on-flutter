import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/app/components/haskell_code_piece.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class AddCode extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    final content = context.get<ContentPiece>("data");

    if (content is SearchContentPiece) {
      context.setResult(HaskellCode(content.data));
      return;
    }
    context.setResult(HaskellCodePiece(content.data));
    return;
  }

  @override
  bool safeCondition(PipelineContext context) {
    final content = context.get<ContentPiece>("data");

    return content != null && content.type == "raw-code";
  }
}
