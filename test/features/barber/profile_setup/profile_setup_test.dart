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

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours() async => result;
}

class _ServicesRepo extends Fake implements IBarberServicesRepo {
  Either<Failure, List<BarberService>> result = const Right([]);

  @override
  Future<Either<Failure, List<BarberService>>> getServices() async => result;
}

class _TeamRepo extends Fake implements IBarberTeamRepo {
  Either<Failure, List<TeamMember>> result = const Right([]);

  @override
  Future<Either<Failure, List<TeamMember>>> getTeam() async => result;
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
  @override
  bool started;
  @override
  bool dismissed;

  _Store({this.started = false, this.dismissed = false});

  @override
  Future<void> markStarted() async => started = true;

  @override
  Future<void> dismiss() async => dismissed = true;
}

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

  ProfileSetupCubit cubit([_Store? store]) => ProfileSetupCubit(
    snapshotCase(),
    store ?? _Store(),
    AppAnalytics(analytics),
  );

  void shopIsSetUp() {
    hours.result = const Right([_open]);
    services.result = Right([_service()]);
  }

  setUp(() {
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

  group('a new shop', () {
    test('sees every step and the team ones wait for a member', () async {
      final c = cubit();
      await c.load();
      c.syncLocal(hasPhoto: false);

      expect(c.state.started, isTrue);
      expect(c.state.visibleSteps, ProfileSetupStep.values);
      expect(c.state.isBlocked(ProfileSetupStep.teamHours), isTrue);
      expect(c.state.isBlocked(ProfileSetupStep.team), isFalse);
      expect(c.state.shouldShowChecklist, isTrue);
    });

    test('the team steps unblock once a member is added', () async {
      shopIsSetUp();
      team.result = Right([_member(10)]);
      final c = cubit(_Store(started: true));

      await c.load();
      c.syncLocal(hasPhoto: true);

      expect(c.state.isBlocked(ProfileSetupStep.teamHours), isFalse);
      expect(c.state.memberFor(ProfileSetupStep.teamHours), 10);
      expect(c.state.progress.doneCount, 4);
    });

    test(
      'is remembered as new so the suggestions stay after the required steps are done',
      () async {
        final store = _Store();
        final c = cubit(store);
        await c.load();
        expect(store.started, isTrue);

        shopIsSetUp();
        await c.load();
        c.syncLocal(hasPhoto: false);

        expect(c.state.requiredIncomplete, isFalse);
        expect(c.state.shouldShowChecklist, isTrue);
        expect(c.state.visibleSteps, contains(ProfileSetupStep.team));
      },
    );

    test(
      'is complete, and reported once, when every visible step is done',
      () async {
        shopIsSetUp();
        team.result = Right([_member(10)]);
        memberHours.byMember[10] = const Right([_open]);
        memberServices.byMember[10] = Right([_service()]);
        final c = cubit(_Store(started: true));

        await c.load();
        c.syncLocal(hasPhoto: false);
        expect(c.state.shouldShowChecklist, isTrue);

        c.syncLocal(hasPhoto: true);

        expect(c.state.progress.isComplete, isTrue);
        expect(c.state.shouldShowChecklist, isFalse);
        expect(analytics.names, ['setup_completed']);
      },
    );

    test('shows the team steps only when the team is known', () async {
      shopIsSetUp();
      team.result = Left(_failure());
      final c = cubit(_Store(started: true));

      await c.load();

      expect(c.state.visibleSteps, [
        ProfileSetupStep.hours,
        ProfileSetupStep.services,
        ProfileSetupStep.photo,
      ]);
    });
  });

  group('an old shop', () {
    test('already set up on first sight never gets suggestions', () async {
      shopIsSetUp();
      final store = _Store();
      final c = cubit(store);

      await c.load();
      c.syncLocal(hasPhoto: false);

      expect(store.started, isFalse);
      expect(c.state.visibleSteps, [
        ProfileSetupStep.hours,
        ProfileSetupStep.services,
      ]);
      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('one that is missing a required step is treated as new', () async {
      hours.result = const Right([_open]);
      final c = cubit();

      await c.load();
      c.syncLocal(hasPhoto: true);

      expect(c.state.started, isTrue);
      expect(c.state.shouldShowChecklist, isTrue);
    });
  });

  group('hiding', () {
    test('hiding removes the card and is remembered', () async {
      final store = _Store();
      final c = cubit(store);
      await c.load();
      c.syncLocal(hasPhoto: false);
      expect(c.state.shouldShowChecklist, isTrue);

      await c.dismiss();

      expect(c.state.shouldShowChecklist, isFalse);
      expect(store.dismissed, isTrue);
    });

    test('a hidden card stays hidden for the next session', () async {
      final c = cubit(_Store(dismissed: true));
      await c.load();
      c.syncLocal(hasPhoto: false);

      expect(c.state.shouldShowChecklist, isFalse);
    });
  });

  group('loading', () {
    test('a failed first load never shows the checklist', () async {
      hours.result = Left(_failure());
      final c = cubit();

      await c.load();
      c.syncLocal(hasPhoto: false);

      expect(c.state.status, ProfileSetupStatus.failure);
      expect(c.state.shouldShowChecklist, isFalse);
    });

    test('a failed refresh keeps what was already shown', () async {
      final c = cubit();
      await c.load();
      c.syncLocal(hasPhoto: false);

      hours.result = Left(_failure());
      await c.load();

      expect(c.state.status, ProfileSetupStatus.success);
      expect(c.state.shouldShowChecklist, isTrue);
    });

    test('waits for the photo before showing anything', () async {
      final c = cubit();

      await c.load();

      expect(c.state.shouldShowChecklist, isFalse);
    });
  });
}
