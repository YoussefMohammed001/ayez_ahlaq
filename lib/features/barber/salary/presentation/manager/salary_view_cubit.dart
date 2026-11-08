import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/member_salary.dart';
import '../../domain/entities/salary_month.dart';
import 'salary_view_state.dart';

abstract class SalaryViewCubit extends Cubit<SalaryViewState> {
  final DateTime Function() clock;

  SalaryViewCubit({DateTime Function()? clock})
    : clock = clock ?? DateTime.now,
      super(SalaryViewState(month: _startOfMonth((clock ?? DateTime.now)())));

  static DateTime _startOfMonth(DateTime date) =>
      DateTime(date.year, date.month);

  Future<Either<Failure, MemberSalary>> fetch(String month);

  @override
  void emit(SalaryViewState state) {
    if (isClosed) return;
    super.emit(state);
  }

  Future<void> load() async {
    if (state.salary == null) {
      emit(state.copyWith(status: SalaryViewStatus.loading));
    }

    final result = await fetch(SalaryMonth.format(state.month));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SalaryViewStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (salary) => emit(
        state.copyWith(status: SalaryViewStatus.success, salary: salary),
      ),
    );
  }

  Future<void> previousMonth() => _goTo(SalaryMonth.previous(state.month));

  Future<void> nextMonth() async {
    if (!state.canShowNext(clock())) return;
    await _goTo(SalaryMonth.next(state.month));
  }

  Future<void> _goTo(DateTime month) async {
    emit(state.copyWith(month: month, status: SalaryViewStatus.loading));
    await load();
  }
}
