class PipelineContext {
  final List<String> messages = [];
  final Map<String, Object> properties = Map<String, Object>();
  bool isAborted = false;

  PipelineContext();
}