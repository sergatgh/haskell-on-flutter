import 'package:connectivity/connectivity.dart';
import 'package:haskell_is_beautiful/base/async_pipeline.dart';
import 'package:haskell_is_beautiful/base/context.dart';

class AbortIfNoInternet extends AsyncProcessor {
  @override
  Future safeExecute(PipelineContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      context.abort();
      context.properties["has_internet"] = false;
    } else {
      context.properties["has_internet"] = true;
    }
  }
}
