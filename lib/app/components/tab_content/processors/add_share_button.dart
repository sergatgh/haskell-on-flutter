import 'package:haskell_is_beautiful/app/components/share_button.dart';
import 'package:haskell_is_beautiful/base/Pipeline.dart';

class AddShareButton extends Processor {
  @override
  Future safeExecute(PipelineContext context) {
    return Future.value(ShareButton());
  }
}