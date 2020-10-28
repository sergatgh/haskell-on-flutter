import 'package:haskell_is_beautiful/base/context.dart';

class Pipeline {
  final List<Processor> processors;

  Pipeline(this.processors);

  T execute<T>(Map<String, Object> props) {
    final context = PipelineContext();
    context.properties.addAll(props);
    this.runProcessors(context);
    return context.getResult<T>();
  }

  void runProcessors<T>(PipelineContext context) {
    for (var processor in this.processors) {
      if (context.isAborted) break;
      processor.execute(context);
    }
  }
}

abstract class Processor {
  void safeExecute(PipelineContext context);
  bool safeCondition(PipelineContext context) {
    return true;
  }

  void execute(PipelineContext context) {
    if (this.safeCondition(context)) {
      this.safeExecute(context);
    }
  }
}

