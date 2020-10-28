import 'package:haskell_is_beautiful/base/context.dart';

class AsyncPipeline {
  final List<AsyncProcessor> processors;

  AsyncPipeline(this.processors);

  Future<TResult> execute<TResult>(Map<String, Object> props) async {
    final context = PipelineContext(props: props);
    await runProcessors(context);
    return context.getResult<TResult>();
  }

  Future runProcessors(PipelineContext context) async {
    for (var processor in this.processors) {
      if (context.isAborted) break;
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

