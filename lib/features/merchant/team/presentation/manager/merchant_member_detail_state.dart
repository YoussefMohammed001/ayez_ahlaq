import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_member.dart';

enum MerchantMemberDetailStatus { initial, loading, success, failure }

class MerchantMemberDetailState extends Equatable {
  final MerchantMemberDetailStatus status;
  final MerchantMember? member;
  final String? errorMessage;
  final bool isSubmitting;

  const MerchantMemberDetailState({
    this.status = MerchantMemberDetailStatus.initial,
    this.member,
    this.errorMessage,
    this.isSubmitting = false,
  });

  MerchantMemberDetailState copyWith({
    MerchantMemberDetailStatus? status,
    MerchantMember? member,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MerchantMemberDetailState(
      status: status ?? this.status,
      member: member ?? this.member,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, member, errorMessage, isSubmitting];
}
