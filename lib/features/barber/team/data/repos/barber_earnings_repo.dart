import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../../domain/entities/earnings.dart';
import '../../domain/entities/member_client.dart';
import '../../domain/repos/i_barber_earnings_repo.dart';
import '../apis/barber_earnings_api.dart';
import '../models/earnings_model.dart';
import '../models/member_client_model.dart';

class BarberEarningsRepo implements IBarberEarningsRepo {
  final BarberEarningsApi _api;

  BarberEarningsRepo(this._api);

  @override
  Future<Either<Failure, Earnings>> getEarnings() async {
    final result = await _api.getEarnings();
    return result.map(
      (response) =>
          EarningsModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, Earnings>> getMemberEarnings(int memberId) async {
    final result = await _api.getMemberEarnings(memberId);
    return result.map(
      (response) =>
          EarningsModel.fromJson(response['data'] as Map<String, dynamic>),
    );
  }

  @override
  Future<Either<Failure, List<MemberClient>>> getMemberClients(
    int memberId, {
    required String from,
    required String to,
  }) async {
    final result = await _api.getMemberClients(memberId, from: from, to: to);
    return result.map((response) {
      final data = response['data'] as List? ?? const [];
      return data
          .map((e) => MemberClientModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
