import 'package:equatable/equatable.dart';
import '../../domain/entities/team_member.dart';

enum BarberTeamStatus { initial, loading, success, failure }

class BarberTeamState extends Equatable {
  final BarberTeamStatus status;
  final List<TeamMember> members;
  final String? errorMessage;
  final bool isSubmitting;

  const BarberTeamState({
    this.status = BarberTeamStatus.initial,
    this.members = const [],
    this.errorMessage,
    this.isSubmitting = false,
  });

  BarberTeamState copyWith({
    BarberTeamStatus? status,
    List<TeamMember>? members,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return BarberTeamState(
      status: status ?? this.status,
      members: members ?? this.members,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, members, errorMessage, isSubmitting];
}
