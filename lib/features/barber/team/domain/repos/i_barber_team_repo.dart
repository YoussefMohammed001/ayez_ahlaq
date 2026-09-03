import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/team_member.dart';
import '../entities/team_member_detail.dart';

abstract class IBarberTeamRepo {
  Future<Either<Failure, List<TeamMember>>> getTeam();

  Future<Either<Failure, TeamMemberDetail>> addMember({
    required String name,
    required String phoneNumber,
    String? tagline,
  });

  Future<Either<Failure, TeamMemberDetail>> getMember(int id);

  Future<Either<Failure, TeamMemberDetail>> updateMember({
    required int id,
    required String name,
    required String tagline,
  });

  Future<Either<Failure, TeamMemberDetail>> setAvailability(
    int id,
    bool available,
  );

  Future<Either<Failure, Unit>> resetPassword(int id, String tempPassword);

  Future<Either<Failure, TeamMemberDetail>> blockMember(int id);

  Future<Either<Failure, TeamMemberDetail>> activateMember(int id);
}
