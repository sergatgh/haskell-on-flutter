class PipelineContext {
  final List<ContextMessage> messages = [];
  final Map<String, Object> properties = Map<String, Object>();
  bool isAborted = false;
  final List<void Function(ContextMessage)> onMessage;

  PipelineContext({Map<String, Object> props = const {}, this.onMessage = const []}) {
    properties.addAll(props);
  }

  operator []=(index, value) => properties[index] = value;

  void abort({String message, MessageType type = MessageType.Information}) {
    isAborted = true;

    if (message != null && message.isNotEmpty) {
      addMessage(message, type: type);
    }
  }

  void addMessage(String message,
      {MessageType type = MessageType.Information}) {

    var contextMessage = ContextMessage(message, type: type);
    messages.add(contextMessage);
    for (var trigger in onMessage) {
      trigger(contextMessage);
    }

  }

  void addError(String message) {
    addMessage(message, type: MessageType.Error);
  }
  
  void addWaring(String message) {
    addMessage(message, type: MessageType.Warning);
  }

  void setResult(Object value) {
    properties["result"] = value;
  }

  bool has<T>(String propertyName) {
    return get<T>(propertyName) != null;
  }

  T get<T>(String propertyName, {T or}) {
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

class ContextMessage {
  final String message;
  final MessageType type;

  ContextMessage(this.message, {this.type = MessageType.Information});
}

enum MessageType { Information, Warning, Error }
