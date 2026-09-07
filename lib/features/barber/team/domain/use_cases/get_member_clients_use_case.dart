import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/member_client.dart';
import '../repos/i_barber_earnings_repo.dart';

class GetMemberClientsUseCase {
  final IBarberEarningsRepo _repo;

  GetMemberClientsUseCase(this._repo);

  Future<Either<Failure, List<MemberClient>>> call(
    int memberId, {
    required String from,
    required String to,
  }) => _repo.getMemberClients(memberId, from: from, to: to);
}
