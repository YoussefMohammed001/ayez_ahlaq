import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/customer_notification_page.dart';
import '../repos/i_customer_notifications_repo.dart';

class GetCustomerNotificationsUseCase {
  final ICustomerNotificationsRepo _repo;

  GetCustomerNotificationsUseCase(this._repo);

  Future<Either<Failure, CustomerNotificationPage>> call({
    required int page,
    required int size,
  }) => _repo.getNotifications(page: page, size: size);
}
