class ApiAction {
  final String eventName;
  final Map<String, Object> parameters;

  const ApiAction(this.eventName, [this.parameters = const {}]);
}
