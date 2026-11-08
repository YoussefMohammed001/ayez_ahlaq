import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/member_salary.dart';
import '../../domain/use_cases/get_my_salary_use_case.dart';
import 'salary_view_cubit.dart';

class MySalaryCubit extends SalaryViewCubit {
  final GetMySalaryUseCase _getMySalary;

  MySalaryCubit(this._getMySalary, {super.clock});

  @override
  Future<Either<Failure, MemberSalary>> fetch(String month) =>
      _getMySalary(month: month);
}
