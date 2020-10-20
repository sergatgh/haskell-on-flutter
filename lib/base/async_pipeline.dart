import 'package:haskell_is_beautiful/base/context.dart';

class AsyncPipeline {
  final List<AsyncProcessor> processors;

  AsyncPipeline(this.processors);

  Future execute(Map<String, Object> props) {
    final context = PipelineContext();
    context.properties.addAll(props);
    return runProcessors(context);
  }

  Future runProcessors<T>(PipelineContext context) async {
    for (var processor in this.processors) {
      await processor.execute(context);
    }
  }
}

abstract class TypedAsyncProcessor<T> {
  Future safeExecute(T context);
  bool safeCondition(T context) {
    return true;
  }

  Future execute(T context) async {
    if (this.safeCondition(context)) {
      await this.safeExecute(context);
    }
  }
}

abstract class AsyncProcessor extends TypedAsyncProcessor<PipelineContext> {
}

