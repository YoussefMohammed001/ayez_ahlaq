import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/subscription.dart';
import '../repos/i_barber_subscription_repo.dart';

class GetBarberSubscriptionUseCase {
  final IBarberSubscriptionRepo _repo;
  GetBarberSubscriptionUseCase(this._repo);
  Future<Either<Failure, Subscription>> call() => _repo.getSubscription();
}
