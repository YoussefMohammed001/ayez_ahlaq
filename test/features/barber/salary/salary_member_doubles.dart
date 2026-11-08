import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ayez_ahlaq/core/error/failure.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_history_page.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_shift.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/entities/attendance_status.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/repos/i_barber_attendance_repo.dart';
import 'package:ayez_ahlaq/features/barber/attendance/domain/use_cases/get_worked_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/attendance/presentation/manager/worked_hours_cubit.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/entities/working_day.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/repos/i_barber_hours_repo.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/use_cases/get_barber_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/hours/domain/use_cases/update_barber_hours_use_case.dart';
import 'package:ayez_ahlaq/features/barber/hours/presentation/manager/barber_hours_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/manager/my_salary_cubit.dart';
import 'package:ayez_ahlaq/features/barber/salary/presentation/pages/my_salary_screen.dart';

class FakeHoursRepo implements IBarberHoursRepo {
  Failure? failure;

  static const week = [
    WorkingDay(
      dayOfWeek: 0,
      isOpen: true,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 1,
      isOpen: true,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 2,
      isOpen: true,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 3,
      isOpen: true,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 4,
      isOpen: true,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 5,
      isOpen: false,
      openTime: '10:00:00',
      closeTime: '18:00:00',
    ),
    WorkingDay(
      dayOfWeek: 6,
      isOpen: true,
      openTime: '12:00:00',
      closeTime: '20:30:00',
    ),
  ];

  @override
  Future<Either<Failure, List<WorkingDay>>> getHours() async =>
      failure != null ? Left(failure!) : const Right(week);

  @override
  Future<Either<Failure, List<WorkingDay>>> updateHours(
    List<WorkingDay> days,
  ) => throw UnimplementedError();
}

class FakeHistoryRepo implements IBarberAttendanceRepo {
  final List<AttendanceShift> shifts;

  FakeHistoryRepo(this.shifts);

  @override
  Future<Either<Failure, AttendanceHistoryPage>> getHistory({
    required int page,
    int size = 20,
    DateTime? from,
  }) async =>
      Right(AttendanceHistoryPage(shifts: shifts, page: 0, totalPages: 1));

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

AttendanceShift todayShift(int minutes) => AttendanceShift(
  id: 1,
  barberId: 10,
  barberName: 'x',
  checkInAt: DateTime.now(),
  checkOutAt: null,
  durationMinutes: minutes,
  status: AttendanceStatus.closed,
  checkInDistanceMeters: null,
  adjustNote: null,
);

Widget mySalaryScreen({
  required MySalaryCubit salary,
  FakeHoursRepo? hours,
  FakeHistoryRepo? history,
}) {
  final hoursRepo = hours ?? FakeHoursRepo();
  final historyRepo = history ?? FakeHistoryRepo([todayShift(90)]);

  return MultiBlocProvider(
    providers: [
      BlocProvider.value(value: salary),
      BlocProvider(
        create: (_) => BarberHoursCubit(
          GetBarberHoursUseCase(hoursRepo),
          UpdateBarberHoursUseCase(hoursRepo),
        )..loadHours(),
      ),
      BlocProvider(
        create: (_) =>
            WorkedHoursCubit(GetWorkedHoursUseCase(historyRepo))..load(),
      ),
    ],
    child: const MySalaryScreen(),
  );
}
