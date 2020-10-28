class PipelineContext {
  final List<String> messages = [];
  final Map<String, Object> properties = Map<String, Object>();
  bool isAborted = false;

  PipelineContext({ Map<String, Object> props = const {} }) {
    properties.addAll(props);
  }

  void abort({String message}) {
    isAborted = true;

    if (message != null && message.isNotEmpty) {
      addMessage(message);
    }
  }

  void addMessage(String message) {
    messages.add(message);
  }

  void setResult(Object value) {
    properties["result"] = value;
  }

  bool has<T>(String propertyName) {
    return get<T>(propertyName) != null;
  }

  T get<T>(String propertyName, { T or }) {
    return getOr<T>(propertyName, or);
  }

  T getResult<T>({T or}) {
    return getOr<T>("result", or);
  }

  T getOr<T>(String propertyName, T defaultValue) {
    if (!properties.containsKey(propertyName)) {
      return defaultValue;
    }

    final val = this.properties[propertyName];
    if (!(val is T)) {
      return defaultValue;
    }

    return val as T;
  }
}
