import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/merchant_member.dart';
import '../entities/merchant_member_permissions.dart';
import '../entities/merchant_members_page.dart';

abstract class IMerchantTeamRepo {
  Future<Either<Failure, MerchantMembersPage>> getMembers({
    required int page,
    required int size,
  });

  Future<Either<Failure, MerchantMember>> getMember(int id);

  Future<Either<Failure, MerchantMember>> addMember({
    required String name,
    required String phoneNumber,
    String? password,
    double? salary,
    MerchantMemberPermissions permissions,
  });

  Future<Either<Failure, MerchantMember>> updateMember({
    required int id,
    String? name,
    String? phoneNumber,
    double? salary,
  });

  Future<Either<Failure, MerchantMember>> setSalary(int id, double salary);

  Future<Either<Failure, MerchantMember>> updatePermissions(
    int id,
    MerchantMemberPermissions permissions,
  );

  Future<Either<Failure, MerchantMember>> blockMember(int id);

  Future<Either<Failure, MerchantMember>> activateMember(int id);

  Future<Either<Failure, Unit>> resetPassword(int id);

  Future<Either<Failure, Unit>> deleteMember(int id);
}
