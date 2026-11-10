import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.token,
    required super.role,
    required super.actorId,
    required super.displayName,
    super.type,
    super.merchantId,
    super.mustChangePassword,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      token: json['token'] as String? ?? '',
      role: json['role'] as String? ?? '',
      actorId: (json['actorId'] as num?)?.toInt() ?? 0,
      displayName: json['displayName'] as String? ?? '',
      type: json['type'] as String? ?? '',
      merchantId: (json['merchantId'] as num?)?.toInt(),
      mustChangePassword: json['mustChangePassword'] as bool? ?? false,
    );
  }
}
