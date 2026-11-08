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
  static const _teamSteps = {
    ProfileSetupStep.team,
    ProfileSetupStep.teamHours,
    ProfileSetupStep.teamServices,
  };

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

  Future<Either<Failure, ProfileSetupSnapshot>> call({
    Set<ProfileSetupStep> alreadyDone = const {},
  }) async {
    final done = {...alreadyDone};

    final pendingHours = done.contains(ProfileSetupStep.hours)
        ? null
        : _getHours();
    final pendingServices = done.contains(ProfileSetupStep.services)
        ? null
        : _getServices();
    final needsTeam = !done.containsAll(_teamSteps);
    final pendingTeam = needsTeam ? _getTeam() : null;

    final hours = await pendingHours;
    final services = await pendingServices;
    final team = await pendingTeam;

    final failure =
        hours?.fold((f) => f, (_) => null) ??
        services?.fold((f) => f, (_) => null);
    if (failure != null) return Left(failure);

    if (hours != null && hours.getOrElse(() => []).any((day) => day.isOpen)) {
      done.add(ProfileSetupStep.hours);
    }
    if (services != null &&
        services.getOrElse(() => []).any((service) => service.active)) {
      done.add(ProfileSetupStep.services);
    }

    if (!needsTeam) {
      return Right(
        ProfileSetupSnapshot(done: done, teamKnown: true, hasTeam: true),
      );
    }

    return Right(await _withTeam(done, team));
  }

  Future<ProfileSetupSnapshot> _withTeam(
    Set<ProfileSetupStep> done,
    Either<Failure, List<dynamic>>? team,
  ) async {
    final members = team?.fold(
      (_) => null,
      (list) => list.where((member) => !member.owner).toList(),
    );
    if (members == null) return ProfileSetupSnapshot(done: done);

    final hasTeam = members.isNotEmpty || done.contains(ProfileSetupStep.team);
    if (members.isEmpty) {
      return ProfileSetupSnapshot(
        done: done,
        teamKnown: true,
        hasTeam: hasTeam,
      );
    }

    final checks = await Future.wait(
      members.map((member) => _inspect(member.id as int)),
    );
    if (checks.any((check) => check == null)) {
      return ProfileSetupSnapshot(done: done);
    }

    final inspected = checks.whereType<_MemberSetup>().toList();

    return ProfileSetupSnapshot(
      done: {
        ...done,
        ProfileSetupStep.team,
        if (inspected.any((m) => m.hoursSet)) ProfileSetupStep.teamHours,
        if (inspected.any((m) => m.servicesSet)) ProfileSetupStep.teamServices,
      },
      teamKnown: true,
      hasTeam: true,
      memberNeedingHours: inspected.where((m) => !m.hoursSet).firstOrNull?.id,
      memberNeedingServices: inspected
          .where((m) => !m.servicesSet)
          .firstOrNull
          ?.id,
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
