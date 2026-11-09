import 'package:equatable/equatable.dart';
import '../../domain/entities/member_commission.dart';

enum MemberCommissionStatus { initial, loading, success, failure }

class MemberCommissionState extends Equatable {
  final MemberCommissionStatus status;
  final MemberCommission commission;
  final bool isSaving;
  final String? errorMessage;

  const MemberCommissionState({
    this.status = MemberCommissionStatus.initial,
    this.commission = const MemberCommission.off(),
    this.isSaving = false,
    this.errorMessage,
  });

  MemberCommissionState copyWith({
    MemberCommissionStatus? status,
    MemberCommission? commission,
    bool? isSaving,
    String? errorMessage,
  }) {
    return MemberCommissionState(
      status: status ?? this.status,
      commission: commission ?? this.commission,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, commission, isSaving, errorMessage];
}
