class AuthTokenMemoryCache {
  const AuthTokenMemoryCache._();

  static String? _token;

  static String? get token => _token;

  static void remember(String? token) => _token = token;

  static void clear() => _token = null;
}
