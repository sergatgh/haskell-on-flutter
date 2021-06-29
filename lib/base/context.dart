class PipelineContext {
  final List<ContextMessage> messages = [];
  final Map<String, Object> properties = Map<String, Object>();
  bool isAborted = false;
  final List<void Function(ContextMessage)> onMessage;

  PipelineContext(
      {Map<String, Object> props = const {}, this.onMessage = const []}) {
    if (props != null) properties.addAll(props);
  }

  operator []=(index, value) => properties[index] = value;

  void abort({String message, MessageType type = MessageType.Error}) {
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
  
  void set(String propertyName, Object value) {
    properties[propertyName] = value;
  }

  void setResult(Object value) {
    properties["result"] = value;
  }

  bool has<T>(String propertyName) {
    return get<T>(propertyName) != null;
  }

  T get<T>(String propertyName, {T Function() or}) {
    return getOr<T>(propertyName, or);
  }

  string(String propertyName, {String Function() or}) {
    return getOr<String>(propertyName, or);
  }

  T getResult<T>({T Function() or}) {
    return getOr<T>("result", or);
  }

  T getOr<T>(String propertyName, T Function() getDefaultValue) {
    if (properties.containsKey(propertyName)) {
      final val = this.properties[propertyName];
      if (val is T) {
        return val;
      }
    }

    if (getDefaultValue != null)
      return getDefaultValue();
    else
      return null;
  }
  
  String getWholeMessage() {
    return this
        .getAllMessages()
        .join("\n");
  }
  
  String getErrorMessage() {
    return this
        .getErrorMessages()
        .join("\n");
  }

  List<String> getAllMessages() {
    return this.messages.map((e) => e.message).toList();
  }

  List<String> getErrorMessages() {
    return this
        .messages
        .where((element) => element.type == MessageType.Error)
        .map((e) => e.message)
        .toList();
  }
}

class ContextMessage {
  final String message;
  final MessageType type;

  ContextMessage(this.message, {this.type = MessageType.Information});
}

enum MessageType { Information, Warning, Error }
