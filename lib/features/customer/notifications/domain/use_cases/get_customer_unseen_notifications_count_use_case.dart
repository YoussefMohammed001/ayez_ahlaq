import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_notifications_repo.dart';

class GetCustomerUnseenNotificationsCountUseCase {
  final ICustomerNotificationsRepo _repo;

  GetCustomerUnseenNotificationsCountUseCase(this._repo);

  Future<Either<Failure, int>> call() => _repo.getUnseenCount();
}
