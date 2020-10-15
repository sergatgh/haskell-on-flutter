import 'package:haskell_is_beautiful/app/components/haskell_code.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class AddCode extends Processor {
  @override
  Future safeExecute(PipelineContext context) {
    final code = context.properties["code"];
    
    return Future.value(HaskellCode(code));
  }
}