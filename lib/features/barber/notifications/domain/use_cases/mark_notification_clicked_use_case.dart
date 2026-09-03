import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_notifications_repo.dart';

class MarkNotificationClickedUseCase {
  final IBarberNotificationsRepo _repo;

  MarkNotificationClickedUseCase(this._repo);

  Future<Either<Failure, Unit>> call(int id) => _repo.markClicked(id);
}
