class HttpCodes {
  static const int ok = 200;
  static const int created = 201;

  static const int unauthorized = 401;
  static const int forbidden = 403;

  static const int serverError = 500;

  static bool isSuccess(int? code) => code != null && code >= 200 && code < 300;
}
