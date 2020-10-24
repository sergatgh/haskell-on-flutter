
import 'package:haskell_is_beautiful/app/components/haskell_code_piece.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class AddCode extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    final content = context.get<ContentPiece>("data");
    
    return HaskellCodePiece(content.data);
  }

  @override
  bool safeCondition(PipelineContext context) {
    final content = context.get<ContentPiece>("data");

    return content != null && content.type == "raw-code";
  }
}