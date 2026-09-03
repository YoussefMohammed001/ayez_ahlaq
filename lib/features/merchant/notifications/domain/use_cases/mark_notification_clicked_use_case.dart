import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_merchant_notifications_repo.dart';

class MarkNotificationClickedUseCase {
  final IMerchantNotificationsRepo _repo;

  MarkNotificationClickedUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.markClicked(id);
}
