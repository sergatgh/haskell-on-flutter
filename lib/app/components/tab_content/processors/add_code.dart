import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';
import 'package:haskell_is_beautiful/base/context.dart';

class AddCode extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    final code = context.properties["code"];
    
    return HaskellCode(code);
  }
}