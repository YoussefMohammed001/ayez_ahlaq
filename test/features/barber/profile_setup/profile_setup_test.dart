import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ayez_ahlaq/core/analytics/app_analytics.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_progress.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/entities/profile_setup_step.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/domain/use_cases/get_profile_setup_remote_steps_use_case.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/manager/profile_setup_cubit.dart';
import 'package:ayez_ahlaq/features/barber/profile_setup/presentation/manager/profile_setup_state.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/entities/barber_service.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/repos/i_barber_services_repo.dart';
import 'package:ayez_ahlaq/features/barber/services/domain/use_cases/get_barber_services_use_case.dart';
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

const _openDay = WorkingDay(
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

void main() {
  late _HoursRepo hours;
  late _ServicesRepo services;
  late GetProfileSetupRemoteStepsUseCase useCase;
  late RecordingAnalytics analytics;

  setUp(() {
    analytics = RecordingAnalytics();
    hours = _HoursRepo();
    services = _ServicesRepo();
    useCase = GetProfileSetupRemoteStepsUseCase(
      GetBarberHoursUseCase(hours),
      GetBarberServicesUseCase(services),
    );
  });

  group('ProfileSetupProgress', () {
    test('counts steps and reports the next one in order', () {
      const progress = ProfileSetupProgress({
        ProfileSetupStep.hours,
        ProfileSetupStep.photo,
      });

      expect(progress.doneCount, 2);
      expect(progress.total, 4);
      expect(progress.fraction, 0.5);
      expect(progress.isComplete, isFalse);
      expect(progress.nextStep, ProfileSetupStep.services);
    });

    test('is complete with every step done and has no next step', () {
      final progress = ProfileSetupProgress(ProfileSetupStep.values.toSet());

      expect(progress.isComplete, isTrue);
      expect(progress.nextStep, isNull);
    });
  });

  group('GetProfileSetupRemoteStepsUseCase', () {
    test('counts hours only when at least one day is open', () async {
      hours.result = const Right([WorkingDay.closed(1), WorkingDay.closed(2)]);
      expect((await useCase()).getOrElse(() => {}), isEmpty);

      hours.result = const Right([WorkingDay.closed(1), _openDay]);
      expect((await useCase()).getOrElse(() => {}), {ProfileSetupStep.hours});
    });

    test('counts services only when one is active', () async {
      services.result = Right([_service(active: false)]);
      expect((await useCase()).getOrElse(() => {}), isEmpty);

      services.result = Right([_service(active: false), _service()]);
      expect((await useCase()).getOrElse(() => {}), {
        ProfileSetupStep.services,
      });
    });

    test('fails when either request fails', () async {
      hours.result = Left(Failure('x', null, const {}));
      expect((await useCase()).isLeft(), isTrue);

      hours.result = const Right([_openDay]);
      services.result = Left(Failure('y', null, const {}));
      expect((await useCase()).isLeft(), isTrue);
    });
  });

  group('ProfileSetupCubit', () {
    test('hides the checklist until photo and documents are known', () async {
      hours.result = const Right([_openDay]);
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));

      await cubit.load();

      expect(cubit.state.status, ProfileSetupStatus.success);
      expect(cubit.state.shouldShowChecklist, isFalse);

      cubit.syncLocal(hasPhoto: false, documentsComplete: false);

      expect(cubit.state.shouldShowChecklist, isTrue);
      expect(cubit.state.progress.doneCount, 1);
    });

    test('hides the checklist once every step is done', () async {
      hours.result = const Right([_openDay]);
      services.result = Right([_service()]);
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));

      await cubit.load();
      cubit.syncLocal(hasPhoto: true, documentsComplete: true);

      expect(cubit.state.progress.isComplete, isTrue);
      expect(cubit.state.shouldShowChecklist, isFalse);
    });

    test('reports completion once, when the last step gets done', () async {
      hours.result = const Right([_openDay]);
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));
      await cubit.load();
      cubit.syncLocal(hasPhoto: true, documentsComplete: false);
      expect(analytics.names, isEmpty);

      services.result = Right([_service()]);
      cubit.syncLocal(hasPhoto: true, documentsComplete: true);
      await cubit.load();

      expect(analytics.names, ['setup_completed']);

      await cubit.load();
      expect(analytics.names, ['setup_completed']);
    });

    test('a failed first load never shows the checklist', () async {
      hours.result = Left(Failure('x', null, const {}));
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));

      await cubit.load();
      cubit.syncLocal(hasPhoto: false, documentsComplete: false);

      expect(cubit.state.status, ProfileSetupStatus.failure);
      expect(cubit.state.shouldShowChecklist, isFalse);
    });

    test('a failed refresh keeps what was already shown', () async {
      hours.result = const Right([_openDay]);
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));
      await cubit.load();
      cubit.syncLocal(hasPhoto: false, documentsComplete: false);

      hours.result = Left(Failure('x', null, const {}));
      await cubit.load();

      expect(cubit.state.status, ProfileSetupStatus.success);
      expect(cubit.state.shouldShowChecklist, isTrue);
    });

    test('picks up a step finished after the checklist was shown', () async {
      final cubit = ProfileSetupCubit(useCase, AppAnalytics(analytics));
      await cubit.load();
      cubit.syncLocal(hasPhoto: false, documentsComplete: false);
      expect(cubit.state.progress.doneCount, 0);

      services.result = Right([_service()]);
      await cubit.load();

      expect(cubit.state.progress.isDone(ProfileSetupStep.services), isTrue);
    });
  });
}
