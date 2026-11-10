import '../../domain/entities/merchant_members_page.dart';
import 'merchant_member_model.dart';

class MerchantMembersPageModel extends MerchantMembersPage {
  const MerchantMembersPageModel({
    required super.members,
    required super.page,
    required super.totalPages,
    required super.totalElements,
  });

  factory MerchantMembersPageModel.fromJson(Map<String, dynamic> json) {
    return MerchantMembersPageModel(
      members: (json['content'] as List<dynamic>? ?? [])
          .map((e) => MerchantMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
    );
  }
}
