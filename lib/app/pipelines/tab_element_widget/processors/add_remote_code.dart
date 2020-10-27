import 'package:haskell_is_beautiful/app/components/remote_haskell_code.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';

class AddRemoteCode extends Processor {
  @override
  void safeExecute(PipelineContext context) {
    final content = context.properties["data"] as ContentPiece;

    context.setResult(RemoteHaskellCode(url: content.data));
  }

  @override
  bool safeCondition(PipelineContext context) {
    final content = context.properties["data"] as ContentPiece;

    return content.type == "remote-code";
  }
}
