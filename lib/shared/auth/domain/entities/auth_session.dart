import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String token;
  final String role;
  final int actorId;
  final String displayName;

  const AuthSession({
    required this.token,
    required this.role,
    required this.actorId,
    required this.displayName,
  });

  @override
  List<Object?> get props => [token, role, actorId, displayName];
}
