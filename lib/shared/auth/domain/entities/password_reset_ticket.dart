import 'package:equatable/equatable.dart';

class PasswordResetTicket extends Equatable {
  final String resetToken;

  const PasswordResetTicket({required this.resetToken});

  @override
  List<Object?> get props => [resetToken];
}
