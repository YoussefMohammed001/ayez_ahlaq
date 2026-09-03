import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/team_member.dart';
import '../../domain/entities/team_member_detail.dart';
import '../../domain/repos/i_barber_team_repo.dart';
import '../apis/barber_team_api.dart';
import '../models/team_member_model.dart';
import '../models/team_member_detail_model.dart';

class BarberTeamRepo implements IBarberTeamRepo {
  final BarberTeamApi _api;

  BarberTeamRepo(this._api);

  @override
  Future<Either<Failure, List<TeamMember>>> getTeam() async {
    final result = await _api.getTeam();
    return result.map(_mapMany);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> addMember({
    required String name,
    required String phoneNumber,
    String? tagline,
  }) async {
    final result = await _api.addMember({
      'name': name,
      'phoneNumber': phoneNumber,
      if (tagline != null) 'tagline': tagline,
    });
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> getMember(int id) async {
    final result = await _api.getMember(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> updateMember({
    required int id,
    required String name,
    required String tagline,
  }) async {
    final result = await _api.updateMember(id, {
      'name': name,
      'tagline': tagline,
    });
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> setAvailability(
    int id,
    bool available,
  ) async {
    final result = await _api.setAvailability(id, available);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
    int id,
    String tempPassword,
  ) async {
    final result = await _api.resetPassword(id, tempPassword);
    return result.map((_) => unit);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> blockMember(int id) async {
    final result = await _api.blockMember(id);
    return result.map(_mapOne);
  }

  @override
  Future<Either<Failure, TeamMemberDetail>> activateMember(int id) async {
    final result = await _api.activateMember(id);
    return result.map(_mapOne);
  }

  List<TeamMember> _mapMany(dynamic response) {
    final data = response['data'] as List? ?? const [];
    return data
        .map((json) => TeamMemberModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  TeamMemberDetail _mapOne(dynamic response) {
    return TeamMemberDetailModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
