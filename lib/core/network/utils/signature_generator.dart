import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignatureGenerator {
  static String generate(String data) {
    final hmac = Hmac(sha256, utf8.encode(""));
    return base64.encode(
      utf8.encode(hmac.convert(utf8.encode(data)).toString()),
    );
  }
}
