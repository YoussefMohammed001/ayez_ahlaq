import 'package:equatable/equatable.dart';
import '../../domain/entities/merchant_member.dart';

enum MyMemberStatus { initial, loading, success, failure }

class MyMerchantMemberState extends Equatable {
  final MyMemberStatus status;
  final MerchantMember? member;
  final String? errorMessage;
  final bool isSubmitting;

  const MyMerchantMemberState({
    this.status = MyMemberStatus.initial,
    this.member,
    this.errorMessage,
    this.isSubmitting = false,
  });

  bool get mustChangePassword => member?.mustChangePassword ?? false;

  MyMerchantMemberState copyWith({
    MyMemberStatus? status,
    MerchantMember? member,
    String? errorMessage,
    bool? isSubmitting,
  }) {
    return MyMerchantMemberState(
      status: status ?? this.status,
      member: member ?? this.member,
      errorMessage: errorMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object?> get props => [status, member, errorMessage, isSubmitting];
}
