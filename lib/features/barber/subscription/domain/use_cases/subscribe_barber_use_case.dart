import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscribe_result.dart';
import '../repos/i_barber_subscription_repo.dart';

class SubscribeBarberUseCase {
  final IBarberSubscriptionRepo _repo;
  SubscribeBarberUseCase(this._repo);
  Future<Either<Failure, SubscribeResult>> call(int planId) =>
      _repo.subscribe(planId);
}
