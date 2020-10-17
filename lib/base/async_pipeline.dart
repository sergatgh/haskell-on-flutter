import 'package:haskell_is_beautiful/base/context.dart';

class AsyncPipeline {
  final List<AsyncProcessor> processors;

  AsyncPipeline(this.processors);

  Future execute(Map<String, Object> props) {
    final context = PipelineContext();
    context.properties.addAll(props);
    return executeWithResult(context);
  }

  Future executeWithResult<T>(PipelineContext context) async {
    for (var processor in this.processors) {
      await processor.execute(context);
    }
  }
}

abstract class AsyncProcessor {
  Future safeExecute(PipelineContext context);
  bool safeCondition(PipelineContext context) {
    return true;
  }

  Future execute(PipelineContext context) async {
    if (this.safeCondition(context)) {
      await this.safeExecute(context);
    }
  }
}

