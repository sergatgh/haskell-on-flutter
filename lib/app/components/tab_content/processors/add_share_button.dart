import 'package:haskell_is_beautiful/app/components/share_button.dart';
import 'package:haskell_is_beautiful/base/pipeline.dart';

class AddShareButton extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    return ShareButton();
  }
}