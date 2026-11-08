import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../../hours/domain/use_cases/get_barber_hours_use_case.dart';
import '../../../services/domain/use_cases/get_barber_services_use_case.dart';
import '../../../team/domain/use_cases/get_member_hours_use_case.dart';
import '../../../team/domain/use_cases/get_member_services_use_case.dart';
import '../../../team/domain/use_cases/get_team_use_case.dart';
import '../entities/profile_setup_snapshot.dart';
import '../entities/profile_setup_step.dart';

class GetProfileSetupSnapshotUseCase {
  final GetBarberHoursUseCase _getHours;
  final GetBarberServicesUseCase _getServices;
  final GetTeamUseCase _getTeam;
  final GetMemberHoursUseCase _getMemberHours;
  final GetMemberServicesUseCase _getMemberServices;

  GetProfileSetupSnapshotUseCase(
    this._getHours,
    this._getServices,
    this._getTeam,
    this._getMemberHours,
    this._getMemberServices,
  );

  Future<Either<Failure, ProfileSetupSnapshot>> call() async {
    final pendingHours = _getHours();
    final pendingServices = _getServices();
    final pendingTeam = _getTeam();
    final hours = await pendingHours;
    final services = await pendingServices;
    final team = await pendingTeam;

    final failure =
        hours.fold((f) => f, (_) => null) ??
        services.fold((f) => f, (_) => null);
    if (failure != null) return Left(failure);

    final done = <ProfileSetupStep>{
      if (hours.getOrElse(() => []).any((day) => day.isOpen))
        ProfileSetupStep.hours,
      if (services.getOrElse(() => []).any((service) => service.active))
        ProfileSetupStep.services,
    };

    final members = team.fold(
      (_) => null,
      (list) => list.where((member) => !member.owner).toList(),
    );
    if (members == null) return Right(ProfileSetupSnapshot(done: done));
    if (members.isEmpty) {
      return Right(ProfileSetupSnapshot(done: done, teamKnown: true));
    }

    final checks = await Future.wait(
      members.map((member) => _inspect(member.id)),
    );
    if (checks.any((check) => check == null)) {
      return Right(ProfileSetupSnapshot(done: done));
    }

    final inspected = checks.whereType<_MemberSetup>().toList();
    final withoutHours = inspected.where((m) => !m.hoursSet);
    final withoutServices = inspected.where((m) => !m.servicesSet);

    return Right(
      ProfileSetupSnapshot(
        done: {
          ...done,
          ProfileSetupStep.team,
          if (inspected.any((m) => m.hoursSet)) ProfileSetupStep.teamHours,
          if (inspected.any((m) => m.servicesSet))
            ProfileSetupStep.teamServices,
        },
        teamKnown: true,
        hasTeam: true,
        memberNeedingHours: withoutHours.firstOrNull?.id,
        memberNeedingServices: withoutServices.firstOrNull?.id,
      ),
    );
  }

  Future<_MemberSetup?> _inspect(int memberId) async {
    final pendingHours = _getMemberHours(memberId);
    final pendingServices = _getMemberServices(memberId);
    final hours = await pendingHours;
    final services = await pendingServices;

    if (hours.isLeft() || services.isLeft()) return null;

    return _MemberSetup(
      memberId,
      hoursSet: hours.getOrElse(() => []).any((day) => day.isOpen),
      servicesSet: services.getOrElse(() => []).any((s) => s.active),
    );
  }
}

class _MemberSetup {
  final int id;
  final bool hoursSet;
  final bool servicesSet;

  const _MemberSetup(
    this.id, {
    required this.hoursSet,
    required this.servicesSet,
  });
}
