import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure.dart';
import '../repos/i_barber_notifications_repo.dart';

class GetUnseenNotificationsCountUseCase {
  final IBarberNotificationsRepo _repo;

  GetUnseenNotificationsCountUseCase(this._repo);

  Future<Either<Failure, int>> call() => _repo.getUnseenCount();
}
