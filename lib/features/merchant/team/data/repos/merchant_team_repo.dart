import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/network/response_guard.dart';
import '../../domain/entities/merchant_member.dart';
import '../../domain/entities/merchant_member_permissions.dart';
import '../../domain/entities/merchant_members_page.dart';
import '../../domain/repos/i_merchant_team_repo.dart';
import '../apis/merchant_team_api.dart';
import '../models/merchant_member_model.dart';
import '../models/merchant_members_page_model.dart';

class MerchantTeamRepo implements IMerchantTeamRepo {
  final MerchantTeamApi _api;

  MerchantTeamRepo(this._api);

  @override
  Future<Either<Failure, MerchantMembersPage>> getMembers({
    required int page,
    required int size,
  }) async {
    final result = await _api.getMembers(page: page, size: size);
    return result.flatMap(
      (response) =>
          requireDataMap(response).map(MerchantMembersPageModel.fromJson),
    );
  }

  @override
  Future<Either<Failure, MerchantMember>> getMember(int id) async {
    final result = await _api.getMember(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> addMember({
    required String name,
    required String phoneNumber,
    String? password,
    double? salary,
    MerchantMemberPermissions permissions = const MerchantMemberPermissions(),
  }) async {
    final result = await _api.addMember({
      'name': name,
      'phoneNumber': phoneNumber,
      'password': ?password,
      'salary': ?salary,
      'canManageProducts': permissions.canManageProducts,
      'canSell': permissions.canSell,
    });
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> updateMember({
    required int id,
    String? name,
    String? phoneNumber,
    double? salary,
  }) async {
    final result = await _api.updateMember(id, {
      'name': ?name,
      'phoneNumber': ?phoneNumber,
      'salary': ?salary,
    });
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> setSalary(
    int id,
    double salary,
  ) async {
    final result = await _api.setSalary(id, salary);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> updatePermissions(
    int id,
    MerchantMemberPermissions permissions,
  ) async {
    final result = await _api.updatePermissions(id, {
      'canManageProducts': permissions.canManageProducts,
      'canSell': permissions.canSell,
    });
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> blockMember(int id) async {
    final result = await _api.blockMember(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, MerchantMember>> activateMember(int id) async {
    final result = await _api.activateMember(id);
    return result.flatMap(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(int id) async {
    final result = await _api.resetPassword(id);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteMember(int id) async {
    final result = await _api.deleteMember(id);
    return result.map((_) => unit);
  }

  Either<Failure, MerchantMember> _mapOne(dynamic response) {
    return requireDataMap(response).map(MerchantMemberModel.fromJson);
  }
}
