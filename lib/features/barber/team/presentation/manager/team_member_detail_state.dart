import 'package:equatable/equatable.dart';
import '../../domain/entities/team_member_detail.dart';

enum TeamMemberDetailStatus { initial, loading, success, failure }

class TeamMemberDetailState extends Equatable {
  final TeamMemberDetailStatus status;
  final TeamMemberDetail? member;
  final String? errorMessage;
  final bool isSubmitting;

  const TeamMemberDetailState({
    this.status = TeamMemberDetailStatus.initial,
    this.member,
    this.errorMessage,
    this.isSubmitting = false,
  });

  TeamMemberDetailState copyWith({
    TeamMemberDetailStatus? status,
    TeamMemberDetail? member,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return TeamMemberDetailState(
      status: status ?? this.status,
      member: member ?? this.member,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, member, errorMessage, isSubmitting];
}
