import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/member_salary.dart';
import '../../domain/entities/salary_type.dart';
import '../../domain/use_cases/clear_member_salary_use_case.dart';
import '../../domain/use_cases/get_member_salary_use_case.dart';
import '../../domain/use_cases/set_member_salary_use_case.dart';
import 'salary_view_cubit.dart';
import 'salary_view_state.dart';

class MemberSalaryCubit extends SalaryViewCubit {
  final GetMemberSalaryUseCase _getSalary;
  final SetMemberSalaryUseCase _setSalary;
  final ClearMemberSalaryUseCase _clearSalary;
  int? _memberId;

  MemberSalaryCubit(
    this._getSalary,
    this._setSalary,
    this._clearSalary, {
    super.clock,
  });

  @override
  Future<Either<Failure, MemberSalary>> fetch(String month) =>
      _getSalary(_memberId!, month: month);

  Future<void> loadMember(int memberId) {
    _memberId = memberId;
    return load();
  }

  Future<bool> save({required SalaryType type, required double amount}) =>
      _change(() => _setSalary(_memberId!, type: type, amount: amount));

  Future<bool> clear() => _change(() => _clearSalary(_memberId!));

  Future<bool> _change(
    Future<Either<Failure, MemberSalary>> Function() action,
  ) async {
    emit(state.copyWith(isSaving: true));

    final result = await action();
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(state.copyWith(isSaving: false, errorMessage: failure.message));
      return false;
    }

    emit(state.copyWith(isSaving: false));
    await load();
    return true;
  }
}
