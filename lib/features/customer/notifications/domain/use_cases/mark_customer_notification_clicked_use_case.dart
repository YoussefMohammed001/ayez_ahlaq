import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_customer_notifications_repo.dart';

class MarkCustomerNotificationClickedUseCase {
  final ICustomerNotificationsRepo _repo;

  MarkCustomerNotificationClickedUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.markClicked(id);
}
