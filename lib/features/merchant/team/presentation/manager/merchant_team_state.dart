import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_member.dart';

enum MerchantTeamStatus { initial, loading, success, failure }

class MerchantTeamState extends Equatable {
  final MerchantTeamStatus status;
  final List<MerchantMember> members;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final bool isSubmitting;
  final String? errorMessage;

  const MerchantTeamState({
    this.status = MerchantTeamStatus.initial,
    this.members = const [],
    this.page = 0,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  MerchantTeamState copyWith({
    MerchantTeamStatus? status,
    List<MerchantMember>? members,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return MerchantTeamState(
      status: status ?? this.status,
      members: members ?? this.members,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    members,
    page,
    hasMore,
    isLoadingMore,
    isSubmitting,
    errorMessage,
  ];
}
