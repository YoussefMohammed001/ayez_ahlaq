import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_step.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/repos/i_profile_setup_store.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/use_cases/get_profile_setup_snapshot_use_case.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/manager/profile_setup_cubit.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/manager/profile_setup_state.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/entities/barber_service.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/repos/i_barber_services_repo.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/use_cases/get_barber_services_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/entities/team_member.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_hours_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/repos/i_barber_team_services_repo.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_member_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_member_services_use_case.dart';
import 'package:ayez_ahlaq/features/barber/team/domain/use_cases/get_team_use_case.dart';
import '../../../support/recording_analytics.dart';

class _HoursRepo extends Fake implements IBarberHoursRepo {
  Either<Failure, List<WorkingDay>> result = const Right([]);
  int calls = 0;

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours() async {
    calls++;
    return result;
  }
}

class _ServicesRepo extends Fake implements IBarberServicesRepo {
  Either<Failure, List<BarberService>> result = const Right([]);
  int calls = 0;

  @override
  Future<Either<Failure, List<BarberService>>> getServices() async {
    calls++;
    return result;
  }
}

class _TeamRepo extends Fake implements IBarberTeamRepo {
  Either<Failure, List<TeamMember>> result = const Right([]);
  int calls = 0;

  @override
  Future<Either<Failure, List<TeamMember>>> getTeam() async {
    calls++;
    return result;
  }
}

class _MemberHoursRepo extends Fake implements IBarberTeamHoursRepo {
  final byMember = <int, Either<Failure, List<WorkingDay>>>{};

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours(int memberId) async =>
      byMember[memberId] ?? const Right([]);
}

class _MemberServicesRepo extends Fake implements IBarberTeamServicesRepo {
  final byMember = <int, Either<Failure, List<BarberService>>>{};

  @override
  Future<Either<Failure, List<BarberService>>> getServices(
    int memberId,
  ) async => byMember[memberId] ?? const Right([]);
}

class _Store implements IProfileSetupStore {
  final done = <int, Set<ProfileSetupStep>>{};
  final hidden = <int, DateTime>{};

  _Store({Set<ProfileSetupStep> done = const {}, DateTime? hiddenAt}) {
    if (done.isNotEmpty) this.done[_owner] = {...done};
    if (hiddenAt != null) hidden[_owner] = hiddenAt;
  }

  @override
  Set<ProfileSetupStep> doneSteps(int ownerId) => {...?done[ownerId]};

  @override
  Future<void> saveDoneSteps(int ownerId, Set<ProfileSetupStep> steps) async =>
      done[ownerId] = {...?done[ownerId], ...steps};

  @override
  DateTime? hiddenAt(int ownerId) => hidden[ownerId];

  @override
  Future<void> hide(int ownerId, DateTime at) async => hidden[ownerId] = at;
}

final _today = DateTime(2026, 11, 8, 12);

const _owner = 7;

const _open = WorkingDay(
  dayOfWeek: 1,
  isOpen: true,
  openTime: '10:00',
  closeTime: '22:00',
);

BarberService _service({bool active = true}) => BarberService(
  id: 1,
  catalogId: 1,
  name: 'قص شعر',
  description: '',
  price: 100,
  durationMinutes: 30,
  popular: false,
  active: active,
);

TeamMember _member(int id, {bool owner = false}) => TeamMember(
  id: id,
  name: 'عضو $id',
  owner: owner,
  you: false,
  rating: 0,
  ratingCount: 0,
  clientsToday: 0,
  clientsThisMonth: 0,
  rank: 0,
);

Failure _failure() => Failure('x', null, const {});

void main() {
  late _HoursRepo hours;
  late _ServicesRepo services;
  late _TeamRepo team;
  late _MemberHoursRepo memberHours;
  late _MemberServicesRepo memberServices;
  late RecordingAnalytics analytics;

  GetProfileSetupSnapshotUseCase snapshotCase() =>
      GetProfileSetupSnapshotUseCase(
        GetBarberHoursUseCase(hours),
        GetBarberServicesUseCase(services),
        GetTeamUseCase(team),
        GetMemberHoursUseCase(memberHours),
        GetMemberServicesUseCase(memberServices),
      );

  late DateTime now;

  ProfileSetupCubit cubit([_Store? store]) => ProfileSetupCubit(
    snapshotCase(),
    store ?? _Store(),
    AppAnalytics(analytics),
    () => now,
  );

  void shopIsSetUp() {
    hours.result = const Right([_open]);
    services.result = Right([_service()]);
  }

  setUp(() {
    now = _today;
    hours = _HoursRepo();
    services = _ServicesRepo();
    team = _TeamRepo();
    memberHours = _MemberHoursRepo();
    memberServices = _MemberServicesRepo();
    analytics = RecordingAnalytics();
  });

  group('snapshot', () {
    test(
      'counts hours only when a day is open and services only when active',
      () async {
        hours.result = const Right([WorkingDay.closed(1), _open]);
        services.result = Right([_service(active: false)]);

        final snapshot = (await snapshotCase()()).getOrElse(
          () => throw StateError('failed'),
        );

        expect(snapshot.done, {ProfileSetupStep.hours});
      },
    );

    test('fails when hours or services cannot be read', () async {
      hours.result = Left(_failure());
      expect((await snapshotCase()()).isLeft(), isTrue);

      hours.result = const Right([_open]);
      services.result = Left(_failure());
      expect((await snapshotCase()()).isLeft(), isTrue);
    });

    test('with no team the team steps are known but not done', () async {
      shopIsSetUp();
      team.result = Right([_member(1, owner: true)]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.teamKnown, isTrue);
      expect(snapshot.hasTeam, isFalse);
      expect(snapshot.done, {
        ProfileSetupStep.hours,
        ProfileSetupStep.services,
      });
    });

    test('the owner alone does not count as a team', () async {
      team.result = Right([_member(1, owner: true)]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.done.contains(ProfileSetupStep.team), isFalse);
    });

    test('one member with hours is enough for the hours step', () async {
      team.result = Right([_member(1, owner: true), _member(10), _member(11)]);
      memberHours.byMember[11] = const Right([_open]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(
        snapshot.done,
        containsAll([ProfileSetupStep.team, ProfileSetupStep.teamHours]),
      );
      expect(snapshot.done.contains(ProfileSetupStep.teamServices), isFalse);
      expect(snapshot.memberNeedingHours, 10);
    });

    test('one member with a service is enough for the services step', () async {
      team.result = Right([_member(10), _member(11)]);
      memberServices.byMember[10] = Right([_service()]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.done.contains(ProfileSetupStep.teamServices), isTrue);
      expect(snapshot.memberNeedingServices, 11);
    });

    test('an inactive service does not count for a member', () async {
      team.result = Right([_member(10)]);
      memberServices.byMember[10] = Right([_service(active: false)]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.done.contains(ProfileSetupStep.teamServices), isFalse);
    });

    test('when everyone is ready nobody is flagged', () async {
      team.result = Right([_member(10)]);
      memberHours.byMember[10] = const Right([_open]);
      memberServices.byMember[10] = Right([_service()]);

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.memberNeedingHours, isNull);
      expect(snapshot.memberNeedingServices, isNull);
    });

    test(
      'a team that cannot be read hides the team steps without failing',
      () async {
        shopIsSetUp();
        team.result = Left(_failure());

        final snapshot = (await snapshotCase()()).getOrElse(
          () => throw StateError('failed'),
        );

        expect(snapshot.teamKnown, isFalse);
        expect(snapshot.done, {
          ProfileSetupStep.hours,
          ProfileSetupStep.services,
        });
      },
    );

    test('a member that cannot be read hides the team steps', () async {
      team.result = Right([_member(10)]);
      memberHours.byMember[10] = Left(_failure());

      final snapshot = (await snapshotCase()()).getOrElse(
        () => throw StateError('failed'),
      );

      expect(snapshot.teamKnown, isFalse);
    });
  });

  group('checklist', () {
    test(
      'shows every step to everyone, with the team ones waiting for a member',
      () async {
        final c = cubit();

        await c.start(_owner);
        await c.syncLocal(hasPhoto: false);

        expect(c.state.visibleSteps, ProfileSetupStep.values);
        expect(c.state.isBlocked(ProfileSetupStep.teamHours), isTrue);
        expect(c.state.isBlocked(ProfileSetupStep.team), isFalse);
        expect(c.state.shouldShowChecklist, isTrue);
      },
    );

    test(
      'an old shop that forgot to fill things sees what is missing',
      () async {
        hours.result = const Right([_open]);
        final c = cubit();

        await c.start(_owner);
        await c.syncLocal(hasPhoto: false);

        expect(c.state.doneSteps, {ProfileSetupStep.hours});
        expect(c.state.shouldShowChecklist, isTrue);
      },
    );

    test('a solo barber is reminded about the team too', () async {
      shopIsSetUp();
      team.result = Right([_member(1, owner: true)]);
      final c = cubit();

      await c.start(_owner);
      await c.syncLocal(hasPhoto: true);

      expect(c.state.shouldShowChecklist, isTrue);
      expect(c.state.visibleSteps, contains(ProfileSetupStep.team));
    });

    test('the team steps unblock once a member is added', () async {
      shopIsSetUp();
      team.result = Right([_member(10)]);
      final c = cubit();

      await c.start(_owner);
      await c.syncLocal(hasPhoto: true);

      expect(c.state.isBlocked(ProfileSetupStep.teamHours), isFalse);
      expect(c.state.memberFor(ProfileSetupStep.teamHours), 10);
      expect(c.state.progress.doneCount, 4);
    });

    test('is complete, and reported once, when every step is done', () async {
      shopIsSetUp();
      team.result = Right([_member(10)]);
      memberHours.byMember[10] = const Right([_open]);
      memberServices.byMember[10] = Right([_service()]);
      final c = cubit();

      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);
      expect(c.state.shouldShowChecklist, isTrue);

      await c.syncLocal(hasPhoto: true);

      expect(c.state.progress.isComplete, isTrue);
      expect(c.state.shouldShowChecklist, isFalse);
      expect(analytics.names, ['setup_completed']);
    });

    test('shows the team steps only when the team is known', () async {
      shopIsSetUp();
      team.result = Left(_failure());
      final c = cubit();

      await c.start(_owner);

      expect(c.state.visibleSteps, [
        ProfileSetupStep.hours,
        ProfileSetupStep.services,
        ProfileSetupStep.photo,
      ]);
    });

    test('waits for the photo before showing anything', () async {
      final c = cubit();

      await c.start(_owner);

      expect(c.state.shouldShowChecklist, isFalse);
    });
  });

  group('keys', () {
    test('what is filled becomes true and is remembered', () async {
      shopIsSetUp();
      final store = _Store();
      final c = cubit(store);

      await c.start(_owner);
      await c.syncLocal(hasPhoto: true);

      expect(store.done[_owner], {
        ProfileSetupStep.hours,
        ProfileSetupStep.services,
        ProfileSetupStep.photo,
      });
    });

    test(
      'a reinstall or an old user gets every filled key set from the data',
      () async {
        shopIsSetUp();
        team.result = Right([_member(10)]);
        memberHours.byMember[10] = const Right([_open]);
        final store = _Store();

        await cubit(store).start(_owner);

        expect(store.done[_owner], {
          ProfileSetupStep.hours,
          ProfileSetupStep.services,
          ProfileSetupStep.team,
          ProfileSetupStep.teamHours,
        });
      },
    );

    test('a key that is true is not asked about again', () async {
      final store = _Store(
        done: {ProfileSetupStep.hours, ProfileSetupStep.services},
      );

      await cubit(store).start(_owner);

      expect(hours.calls, 0);
      expect(services.calls, 0);
      expect(team.calls, 1);
    });

    test('when every key is true nothing is asked at all', () async {
      final store = _Store(done: ProfileSetupStep.values.toSet());
      final c = cubit(store);

      await c.start(_owner);
      await c.syncLocal(hasPhoto: true);

      expect(hours.calls + services.calls + team.calls, 0);
      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('a key stays true even if the data is removed later', () async {
      shopIsSetUp();
      final store = _Store();
      await cubit(store).start(_owner);

      hours.result = const Right([]);
      final again = cubit(store);
      await again.start(_owner);

      expect(again.state.doneSteps, contains(ProfileSetupStep.hours));
    });

    test('only the missing keys are fetched', () async {
      final store = _Store(done: {ProfileSetupStep.hours});
      services.result = Right([_service()]);

      await cubit(store).start(_owner);

      expect(hours.calls, 0);
      expect(services.calls, 1);
    });

    test('a refresh after a step keeps what was already known', () async {
      final c = cubit();
      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);
      expect(c.state.doneSteps, isEmpty);

      hours.result = const Right([_open]);
      await c.load();

      expect(c.state.doneSteps, {ProfileSetupStep.hours});
    });

    test('each account has its own keys', () async {
      shopIsSetUp();
      final store = _Store();

      await cubit(store).start(_owner);
      await cubit(store).start(99);

      expect(store.done[_owner], isNotEmpty);
      expect(store.done[99], isNotEmpty);
      expect(hours.calls, 2);
    });
  });

  group('hiding', () {
    test('hiding removes the card and remembers when', () async {
      final store = _Store();
      final c = cubit(store);
      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);
      expect(c.state.shouldShowChecklist, isTrue);

      await c.dismiss();

      expect(c.state.shouldShowChecklist, isFalse);
      expect(store.hidden[_owner], _today);
    });

    test('stays hidden for the next session within two days', () async {
      final store = _Store(
        hiddenAt: _today.subtract(const Duration(hours: 47)),
      );
      final c = cubit(store);

      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);

      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('comes back after two days if something is still missing', () async {
      final store = _Store(hiddenAt: _today.subtract(const Duration(days: 2)));
      final c = cubit(store);

      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);

      expect(c.state.shouldShowChecklist, isTrue);
    });

    test('hiding again starts a new two days', () async {
      final store = _Store(hiddenAt: _today.subtract(const Duration(days: 5)));
      final c = cubit(store);
      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);

      await c.dismiss();

      expect(store.hidden[_owner], _today);
      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('hiding is per account', () async {
      final store = _Store(hiddenAt: _today);
      final other = cubit(store);

      await other.start(99);
      await other.syncLocal(hasPhoto: false);

      expect(other.state.shouldShowChecklist, isTrue);
    });

    test('hiding does nothing before the account is known', () async {
      final c = cubit();

      await c.dismiss();

      expect(c.state.dismissed, isFalse);
    });
  });

  group('loading', () {
    test('a failed first load never shows the checklist', () async {
      hours.result = Left(_failure());
      final c = cubit();

      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);

      expect(c.state.status, ProfileSetupStatus.failure);
      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('a failed refresh keeps what was already shown', () async {
      final c = cubit();
      await c.start(_owner);
      await c.syncLocal(hasPhoto: false);

      hours.result = Left(_failure());
      await c.load();

      expect(c.state.status, ProfileSetupStatus.success);
      expect(c.state.shouldShowChecklist, isTrue);
    });

    test('starting twice for the same account asks once', () async {
      final c = cubit();

      await c.start(_owner);
      await c.start(_owner);

      expect(hours.calls, 1);
    });

    test('nothing happens before start', () async {
      final c = cubit();

      await c.load();

      expect(hours.calls, 0);
      expect(c.state.status, ProfileSetupStatus.initial);
    });
  });
}
