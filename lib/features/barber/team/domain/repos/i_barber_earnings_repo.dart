import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/earnings.dart';
import '../entities/member_client.dart';

abstract class IBarberEarningsRepo {
  Future<Either<Failure, Earnings>> getEarnings();

  Future<Either<Failure, Earnings>> getMemberEarnings(int memberId);

  Future<Either<Failure, List<MemberClient>>> getMemberClients(
    int memberId, {
    required String from,
    required String to,
  });
}
