import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/earnings.dart';
import '../repos/i_barber_earnings_repo.dart';

class GetMemberEarningsUseCase {
  final IBarberEarningsRepo _repo;

  GetMemberEarningsUseCase(this._repo);

  Future<Either<Failure, Earnings>> call(int memberId) =>
      _repo.getMemberEarnings(memberId);
}
