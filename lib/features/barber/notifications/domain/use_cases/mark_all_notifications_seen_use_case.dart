import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_notifications_repo.dart';

class MarkAllNotificationsSeenUseCase {
  final IBarberNotificationsRepo _repo;

  MarkAllNotificationsSeenUseCase(this._repo);

  Future<Either<Failure, Unit>> call() => _repo.markAllSeen();
}
