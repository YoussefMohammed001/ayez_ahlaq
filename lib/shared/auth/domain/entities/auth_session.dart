import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String token;
  final String role;
  final int actorId;
  final String displayName;
  final String type;
  final int? merchantId;
  final bool mustChangePassword;

  const AuthSession({
    required this.token,
    required this.role,
    required this.actorId,
    required this.displayName,
    this.type = '',
    this.merchantId,
    this.mustChangePassword = false,
  });

  @override
  List<Object?> get props => [
    token,
    role,
    actorId,
    displayName,
    type,
    merchantId,
    mustChangePassword,
  ];
}
