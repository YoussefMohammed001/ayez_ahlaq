import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_notifications_repo.dart';

class MarkAllCustomerNotificationsSeenUseCase {
  final ICustomerNotificationsRepo _repo;

  MarkAllCustomerNotificationsSeenUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.markAllSeen();
}
