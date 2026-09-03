import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../entities/notification_page.dart';
import '../repos/i_merchant_notifications_repo.dart';

class GetNotificationsUseCase {
  final IMerchantNotificationsRepo _repo;

  GetNotificationsUseCase(this._repo);

  Future<Either<Failure, NotificationPage>> call({
    required int page,
    required int size,
  }) => _repo.getNotifications(page: page, size: size);
}
