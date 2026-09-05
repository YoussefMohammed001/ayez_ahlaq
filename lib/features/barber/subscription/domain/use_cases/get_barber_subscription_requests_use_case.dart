import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription_request.dart';
import '../repos/i_barber_subscription_repo.dart';

class GetBarberSubscriptionRequestsUseCase {
  final IBarberSubscriptionRepo _repo;
  GetBarberSubscriptionRequestsUseCase(this._repo);
  Future<Either<Failure, List<SubscriptionRequest>>> call() =>
      _repo.getRequests();
}
