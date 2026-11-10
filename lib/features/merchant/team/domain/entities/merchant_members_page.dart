import 'package:equatable/equatable.dart';
import 'merchant_member.dart';

class MerchantMembersPage extends Equatable {
  final List<MerchantMember> members;
  final int page;
  final int totalPages;
  final int totalElements;

  const MerchantMembersPage({
    required this.members,
    required this.page,
    required this.totalPages,
    required this.totalElements,
  });

  bool get hasMore => page + 1 < totalPages;

  @override
  List<Object?> get props => [members, page, totalPages, totalElements];
}
