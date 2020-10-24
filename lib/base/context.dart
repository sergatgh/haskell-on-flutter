class PipelineContext {
  final List<String> messages = [];
  final Map<String, Object> properties = Map<String, Object>();
  bool isAborted = false;

  PipelineContext({ Map<String, Object> props = const {} }) {
    properties.addAll(props);
  }

  void addError(String message) {
    messages.add(message);
  }

  void setResult(Object value) {
    properties["result"] = value;
  }

  bool has<T>(String propertyName) {
    return get<T>(propertyName) != null;
  }

  T get<T>(String propertyName) {
    return getOrDefault<T>(propertyName, null);
  }

  T getResult<T>() {
    return getOrDefault<T>("result", null);
  }

  T getOrDefault<T>(String propertyName, T defaultValue) {
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
