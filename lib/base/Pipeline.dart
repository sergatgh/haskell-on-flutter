class Pipeline {
  final List<Processor> processors;

  Pipeline(this.processors);

  Future<List<T>> execute<T>(Map<String, Object> props) {
    final context = PipelineContext();
    context.properties.addAll(props);
    return executeWithResult(context);
  }

  Future<List<T>> executeWithResult<T>(PipelineContext context) async {
    for (var processor in this.processors) {
      await processor.execute(context);
    }
    final result = context.properties["result"] as List;
    return result.cast<T>().toList();
  }
}

abstract class Processor {
  Future<Object> safeExecute(PipelineContext context);
  bool safeCondition(PipelineContext context) {
    return true;
  }

  Future execute(PipelineContext context) async {
    if (!context.properties.containsKey("result")) {
      context.properties["result"] = new List();
    }

    final resultArray = context.properties["result"] as List;

    if (this.safeCondition(context)) {
      final result = await this.safeExecute(context);

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