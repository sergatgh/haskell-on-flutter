class Pipeline {
  final List<Processor> processors;

  Pipeline(this.processors);

  List<T> execute<T>(Map<String, Object> props) {
    final context = PipelineContext();
    context.properties.addAll(props);
    return executeWithResult(context);
  }

  List<T> executeWithResult<T>(PipelineContext context) {
    for (var processor in this.processors) {
      processor.execute(context);
    }
    final result = context.properties["result"] as List;
    return result.cast<T>().toList();
  }
}

abstract class Processor {
  Object safeExecute(PipelineContext context);
  bool safeCondition(PipelineContext context) {
    return true;
  }

  void execute(PipelineContext context) {
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = new List();
    }

    final resultArray = context.properties["result"] as List;

    if (this.safeCondition(context)) {
      final result = this.safeExecute(context);

      if (result != null) {
        resultArray.add(result);
      }
    }
  }
}

class PipelineContext {
  final List<String> messages = [];
  final Map<String, Object> properties = Map<String, Object>();

  PipelineContext();
}