class ApiActionRule {
  final String method;
  final RegExp pattern;
  final String event;

  ApiActionRule(this.method, String pattern, this.event)
    : pattern = RegExp(pattern);

  ApiActionRule.post(String pattern, String event)
    : this('POST', pattern, event);

  ApiActionRule.put(String pattern, String event) : this('PUT', pattern, event);

  ApiActionRule.delete(String pattern, String event)
    : this('DELETE', pattern, event);

  bool matches(String verb, String path) =>
      verb == method && pattern.hasMatch(path);
}
