import 'auth_session_model.dart';

class RegisterResponseModel {
  final bool activated;
  final AuthSessionModel? session;

  const RegisterResponseModel({required this.activated, this.session});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final auth = json['auth'];
    final session = auth is Map<String, dynamic>
        ? AuthSessionModel.fromJson(auth)
        : null;

    return RegisterResponseModel(
      activated: json['activated'] as bool? ?? false,
      session: session != null && session.token.isNotEmpty ? session : null,
    );
  }
}
